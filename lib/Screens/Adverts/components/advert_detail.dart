import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class AdvertDetails extends StatefulWidget {
  final Size size;
  final String imagePath;
  final String adTitle;
  final String adBody;

  const AdvertDetails(
      {super.key,
      required this.size,
      required this.imagePath,
      required this.adTitle,
      required this.adBody});

  @override
  State<StatefulWidget> createState() => _PetAdvertPageState();
}

class _PetAdvertPageState extends State<AdvertDetails> {
  int _selectedIndex = 1;
  int _page = 1;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _page = index;
    });

    // Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.fade,
    //       child: AdvertScreen(),
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.adTitle),
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: _page == 0
            ? Colors.brown
            : _page == 1
                ? Colors.blue
                : _page == 2
                    ? Colors.green
                    : Colors.purple,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: widget.size.height * 0.738,
                width: widget.size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.imagePath), fit: BoxFit.fill),
                ),
                child: Column(children: <Widget>[
                  const SizedBox(height: 100),
                  Text(
                    widget.adTitle,
                    style: TextStyle(background: Paint()..color = Colors.grey),
                  ),
                  const SizedBox(height: 100),
                  Text(widget.adBody,
                      style:
                          TextStyle(background: Paint()..color = Colors.grey))
                ]))
          ]),
      bottomNavigationBar: CurvedNavigationBar(
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.assignment, size: 30),
            Icon(Icons.message, size: 30),
            Icon(Icons.account_box, size: 30)
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: _selectedIndex == 0
              ? Colors.brown
              : _selectedIndex == 1
                  ? Colors.lightBlue
                  : _selectedIndex == 2
                      ? Colors.green
                      : Colors.purple,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: const Duration(milliseconds: 1500),
          onTap: _onItemTapped,
          index: 1),
    );
  }
}
