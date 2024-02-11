import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petpal_flutter/components/rounded_button.dart';
import 'package:petpal_flutter/components/rounded_input_field.dart';
import 'package:petpal_flutter/constants.dart';
import 'package:petpal_flutter/main.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              createAdvertText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: newAdvertTitleHint,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: newAdvertDescriptionHint,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: newAdvertAnimalTypeHint,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: newAdvertImageHint,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: createAdvertButtonText,
              onPressed: () => {
                Fluttertoast.showToast(
                    msg: "Creating a new advert with the above information!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1),
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: PetPalHomePage.noAppProvided(
                          title: mainTitle,
                        )))
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  // void _showToast(BuildContext context) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: const Text('Create button clicked!'),
  //       action: SnackBarAction(
  //           label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }
}
