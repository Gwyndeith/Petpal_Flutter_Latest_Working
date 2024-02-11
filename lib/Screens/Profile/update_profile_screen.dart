import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petpal_flutter/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key, required this.firebaseApp}) : super(key: key);
  final FirebaseApp firebaseApp;

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState(FirebaseAuth.instanceFor(app: firebaseApp).currentUser, firebaseApp);
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>{
  _UpdateProfileScreenState(this.user, this.firebaseApp);

  User? user;
  FirebaseApp firebaseApp;
  bool _eyeState = true; //true hides password, false shows password
  bool _eyeStateConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.navigate_before_rounded)),
        title: Text('Edit Profile', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(FirebaseAuth.instanceFor(app: firebaseApp).currentUser!.photoURL as String)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: kPrimaryColor),
                      child: const Icon(Icons.photo, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      //TODO: INSERT USERNAME FROM DJANGO DATABASE
                      //initialValue: ,
                      decoration: const InputDecoration(
                          label: Text('Username:'), prefixIcon: Icon(Icons.verified_user)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Email:'), prefixIcon: Icon(Icons.mail)),
                      initialValue: user!.email as String,
                      enabled: false,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      //TODO: INSERT USER PHONE NUMBER FROM DJANGO DATABASE
                      //initialValue: ,
                      decoration: const InputDecoration(
                          label: Text('Phone no:'), prefixIcon: Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: _eyeState,
                      decoration: InputDecoration(
                        label: const Text('Password:'),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(icon: Icon(_eyeState ? Icons.remove_red_eye : Icons.remove_red_eye_outlined), onPressed: () {
                          setState(() {
                            _eyeState = !_eyeState;
                          });
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: _eyeStateConfirmation,
                      decoration: InputDecoration(
                        label: const Text('Please enter password again:'),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(icon: Icon(_eyeState ? Icons.remove_red_eye : Icons.remove_red_eye_outlined), onPressed: () {
                          setState(() {
                            _eyeStateConfirmation = !_eyeStateConfirmation;
                          });
                        }),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => UpdateProfileScreen(firebaseApp: firebaseApp)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Joined:\n',
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
                              backgroundColor: Colors.red.withOpacity(0.9),
                              elevation: 0,
                              foregroundColor: Colors.white,
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