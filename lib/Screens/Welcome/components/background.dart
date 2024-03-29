import 'package:flutter/material.dart';
import 'package:petpal_flutter/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Width and height of the screen.
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              mainTopPNG,
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: size.width * 0.2,
            child: Image.asset(
              mainBottomPNG,
              width: size.width * 0.3,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
