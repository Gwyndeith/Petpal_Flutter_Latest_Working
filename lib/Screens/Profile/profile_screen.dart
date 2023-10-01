import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:petpal_flutter/Screens/Profile/update_profile_screen.dart';
import 'package:petpal_flutter/constants.dart';

import 'components/user_profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.user, required this.firebaseApp}) : super(key: key);
  final FirebaseApp firebaseApp;

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Press to increase the counter',
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage("assets/images/pet_lineup.jpg"))),
                  ),
                ],
              ),
              Text(user!.displayName as String, style: Theme.of(context).textTheme.headlineMedium),
              Text(user!.email as String, style: Theme.of(context).textTheme.bodyMedium),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen(firebaseApp: firebaseApp,)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text('Edit Profile', style: TextStyle(color: kDefaultIconDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: Icons.settings, onPress: () {}),
              ProfileMenuWidget(title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: Icons.manage_accounts, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () => Fluttertoast.showToast(msg: 'Logout button pressed!'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}