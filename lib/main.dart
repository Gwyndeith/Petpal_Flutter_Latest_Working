import 'dart:convert';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petpal_flutter/Screens/Welcome/welcome_screen.dart';
import 'package:petpal_flutter/constants.dart';

import 'Screens/Adverts/advert_screen.dart';
import 'Screens/Adverts/components/advert_container.dart';
import 'Screens/Adverts/components/advert_detail.dart';
import 'Screens/Adverts/pet_advert.dart';
import 'Screens/Create/create_screen.dart';

void main() {
  runApp(MyApp());
}

MaterialColor createMaterialColor(Color kPrimaryColor) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = kPrimaryColor.red,
      g = kPrimaryColor.green,
      b = kPrimaryColor.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(kPrimaryColor.value, swatch);
}

Future<void> _checkLocationPermission(int askedCount) async {
  final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
  final isGpsOn = serviceStatus == ServiceStatus.enabled;
  if (!isGpsOn) {
    return;
  }

  final status = await Permission.locationWhenInUse.request();
  if (status == PermissionStatus.granted) {
    _checkNotificationsPermission(0);
  } else if (status == PermissionStatus.denied && askedCount < 1) {
    _checkLocationPermission(++askedCount);
  } else if (status == PermissionStatus.permanentlyDenied ||
      (status == PermissionStatus.denied && askedCount >= 1)) {
    _checkNotificationsPermission(0);
    await openAppSettings();
  }
}

Future<void> _checkNotificationsPermission(int askedCount) async {
  final notificationStatus = await Permission.notification.request();
  if (notificationStatus == PermissionStatus.granted) {
    _checkStoragePermission(0);
  } else if (notificationStatus == PermissionStatus.denied && askedCount < 1) {
    _checkNotificationsPermission(++askedCount);
  } else if (notificationStatus == PermissionStatus.permanentlyDenied ||
      (notificationStatus == PermissionStatus.denied && askedCount >= 1)) {
    _checkStoragePermission(0);
    await openAppSettings();
  }
}

Future<void> _checkStoragePermission(int askedCount) async {
  final storagePermissionStatus = await Permission.storage.request();
  if (storagePermissionStatus == PermissionStatus.granted) {
  } else if (storagePermissionStatus == PermissionStatus.denied &&
      askedCount < 1) {
    _checkStoragePermission(++askedCount);
  } else if (storagePermissionStatus == PermissionStatus.permanentlyDenied ||
      (storagePermissionStatus == PermissionStatus.denied && askedCount >= 1)) {
    await openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    _checkLocationPermission(0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: mainTitle,
      theme: ThemeData(
          primarySwatch: createMaterialColor(kPrimaryColor),
          scaffoldBackgroundColor: Colors.grey,
          textTheme: const TextTheme(
              headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ))),
      home: WelcomeScreen(),
    );
  }
}

class PetPalHomePage extends StatefulWidget {
  const PetPalHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PetPalPageState createState() => _PetPalPageState();
}

class _PetPalPageState extends State<PetPalHomePage> {
  Client client = http.Client();
  List<PetAdvert> petAds = [];

  int _counter = 0;
  int _selectedIndex = 0;
  int _page = 0;
  String _pageMessage = 'Ana Ekran';

  @override
  void initState() {
    _getPetAds();
    super.initState();
  }

  _getPetAds() async {
    petAds = [];

    List response = json.decode((await client.get(Uri.parse(
            'https://gwyndeith.pythonanywhere.com/petpal/petads/')))
        .body);

    response.forEach((element) {
      petAds.add(PetAdvert.fromMap(element));
    });
    Fluttertoast.showToast(
        msg: 'There are currently ${petAds.length} adverts!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
    setState(() {});
  }

  Widget _getAdvertList() {
    return Column(children: <Widget>[
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: petAds.length,
        itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          InkWell(
              child: AdvertContainer(
                size: MediaQuery.of(context).size,
                adTitle: petAds.elementAt(index).title,
                assetPath: petAds.elementAt(index).imagePath,
              ),
              onTap: () {
                /*
                Fluttertoast.showToast(
                    msg:
                        'Tapped on advert with index: ${petAds.elementAt(index).id}!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1);
                  */

                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: AdvertDetails(
                          size: MediaQuery.of(context).size,
                          adTitle: petAds.elementAt(index).title,
                          adBody: petAds.elementAt(index).body,
                          imagePath: petAds.elementAt(index).imagePath
                      ),
                    ));
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ]),
      )
    ]);
  }

  static const List<String> _widgetOptions = <String>[
    'Ana Ekran',
    'İlanlar',
    'Mesajlar',
    'Profil',
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _page = index;
      _pageMessage = _widgetOptions.elementAt(index);
    });

    // Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.fade,
    //       child: AdvertScreen(),
    //     ));
  }

  void _addNewAdvert() {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: CreateScreen(),
        ));
  }

  Widget getAdverts() {
    Size size = MediaQuery.of(context).size;
    return _getAdvertList(); /*<Widget>[
      SizedBox(
        height: size.height * 0.02,
      ),
      InkWell(
        child: AdvertContainer(
          size: size,
          adTitle: 'Puppy in need of home!',
          assetPath: 'assets/images/puppy_ad1.jpg',
        ),
        onTap: () {
          Fluttertoast.showToast(
              msg: "Tapped on container!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        },
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
      InkWell(
        child: AdvertContainer(
          size: size,
          adTitle: 'Puppy in need of home!',
          assetPath: 'assets/images/puppy_ad2.jpg',
        ),
        onTap: () {
          Fluttertoast.showToast(
              msg: "Tapped on container!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        },
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
      InkWell(
        child: AdvertContainer(
          size: size,
          adTitle: 'Puppy in need of home!',
          assetPath: 'assets/images/puppy_ad2.jpg',
        ),
        onTap: () {
          Fluttertoast.showToast(
              msg: "Tapped on container!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        },
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
      InkWell(
        child: AdvertContainer(
          size: size,
          adTitle: 'Puppy in need of home!',
          assetPath: 'assets/images/puppy_ad1.jpg',
        ),
        onTap: () {
          Fluttertoast.showToast(
              msg: "Tapped on container!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        },
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
      RoundedButton(
        onPressed: _addNewAdvert,
        text: createAdvertButtonText,
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
    ];*/
  }

  Widget bodyFunction() {
    switch (_page) {
      case 0:
        return Center(
            child: Container(
          color: Colors.brown,
          child: Text(
            _counter.toString(),
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
        ));
      case 1:
        Size size = MediaQuery.of(context).size;
        return Center(
          child: SingleChildScrollView(
              child:
                  getAdverts() /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getAdverts(),
            ),*/
              ),
        );
      case 2:
        return Center(
            child: Container(
          color: Colors.green,
          child: Text(
            _counter.toString(),
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
        ));
      default:
        return Center(
            child: Container(
          color: _selectedIndex == 0 ? Colors.brown : _selectedIndex == 1 ? Colors.lightBlue : _selectedIndex == 2 ? Colors.green : Colors.purple,
          child: Text(
            _counter.toString(),
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_pageMessage),
        centerTitle: true,
      ),
      body: bodyFunction(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Press to increase the counter',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.assignment, size: 30),
            Icon(Icons.message, size: 30),
            Icon(Icons.account_box, size: 30)
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: _selectedIndex == 0 ? Colors.brown : _selectedIndex == 1 ? Colors.lightBlue : _selectedIndex == 2 ? Colors.green : Colors.purple,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: Duration(milliseconds: 1500),
          onTap: _onItemTapped,
          index:
              _selectedIndex), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
