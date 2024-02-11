import 'package:flutter/material.dart';

class AdvertContainer extends StatelessWidget {
  final Size size;
  final String assetPath;
  final String adTitle;

  const AdvertContainer(
      {super.key, required this.adTitle, required this.assetPath, required this.size});

  //_AdvertContainerState createState() => _AdvertContainerState(size, assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(assetPath), fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[Text(adTitle)],
      ),
    );
  }
}
