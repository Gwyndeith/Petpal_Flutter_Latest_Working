import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petpal_flutter/Screens/Login/login_screen.dart';
import 'package:petpal_flutter/Screens/Signup/components/social_icon.dart';
import 'package:petpal_flutter/components/already_have_an_account_check.dart';
import 'package:petpal_flutter/components/rounded_button.dart';
import 'package:petpal_flutter/components/rounded_input_field.dart';
import 'package:petpal_flutter/components/rounded_password_field.dart';
import 'package:petpal_flutter/constants.dart';

import 'background.dart';
import 'or_divider.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  void signUpProcess() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              signupText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              signupSVG,
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: emailAddressHint,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: signupText,
              onPressed: () {
                signUpProcess();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: facebookSVG,
                  onPressed: () {},
                ),
                SocialIcon(
                  iconSrc: twitterSVG,
                  onPressed: () {},
                ),
                SocialIcon(
                  iconSrc: googleplusSVG,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
