import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final String? imagePath;
  final double? opacity;
  const BackgroundWidget({Key? key , required this.imagePath , required this.opacity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(imagePath! , scale: 0.5),
              fit: BoxFit.fill,
              opacity: opacity!
          )
      ),
    );
  }
}
