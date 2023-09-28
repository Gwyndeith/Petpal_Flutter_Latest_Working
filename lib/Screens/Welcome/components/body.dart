import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petpal_flutter/Screens/Login/login_screen.dart';
import 'package:petpal_flutter/Screens/Signup/signup_screen.dart';
import 'package:petpal_flutter/constants.dart';
import 'package:petpal_flutter/main.dart';

import '../../../components/google_sign_in_button.dart';
import '../../../components/rounded_button.dart';
import '../../../custom_colors.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              mainTitleAsString,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              chatSVG,
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: loginText,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: signupText,
              color: kPrimaryLightColor,
              textColor: Colors.black,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            InkWell(
              child: Container(
                  width: size.width / 2,
                  height: 50,
                  margin: const EdgeInsets.only(top: 2, bottom: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 27.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/icons/google_sign_in.svg'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ))),
              onTap: () async {
                FutureBuilder(
                  future: initializeFirebase(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColors.firebaseOrange,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static Future<FirebaseApp> initializeFirebase(BuildContext context) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
        name: "PetPal",
        options: const FirebaseOptions(
            apiKey: "AIzaSyCrA7BZaQKsYwnGgWhxI-v07LwTNqIlx4I",
            appId: "1:92685570900:android:f69e4ea9de2493d32daec1",
            messagingSenderId: "92685570900",
            projectId: "petpal-8775a"));

    signInWithGoogle(context: context, firebaseApp: firebaseApp);

    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: PetPalHomePage(
              title: mainTitle,
            )));

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle(
      {required BuildContext context, required FirebaseApp firebaseApp}) async {
    FirebaseAuth auth = FirebaseAuth.instanceFor(app: firebaseApp);
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
}
