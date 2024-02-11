
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petpal_flutter/Screens/Login/login_screen.dart';
import 'package:petpal_flutter/Screens/Signup/signup_screen.dart';
import 'package:petpal_flutter/constants.dart';

import '../../../components/google_sign_in_button.dart';
import '../../../components/rounded_button.dart';
import '../../../custom_colors.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                      return const LoginScreen();
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
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
            GoogleSignInButton(),
          ],
        ),
      ),
    );
  }
}
