import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petpal_flutter/constants.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key, required this.firebaseApp}) : super(key: key);
  final FirebaseApp firebaseApp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_right)),
        title: Text('Edit Profile', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size as double),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('assets/images/pet_lineup.jpg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: kPrimaryColor),
                      child: const Icon(Icons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Username:'), prefixIcon: Icon(Icons.verified_user)),
                    ),
                    const SizedBox(height: 240 - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Email:'), prefixIcon: Icon(Icons.mail)),
                    ),
                    const SizedBox(height: 240 - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Phone no:'), prefixIcon: Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 240 - 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text('Password:'),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon:
                        IconButton(icon: const Icon(Icons.android), onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: 240),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => UpdateProfileScreen(firebaseApp: firebaseApp)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Edit Profile', style: TextStyle(color: kDefaultIconDarkColor)),
                      ),
                    ),
                    const SizedBox(height: 240),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Joined',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: 'Joined at:',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text('Delete'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}