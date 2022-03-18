import 'package:flutter/material.dart';

class CustomTextViewer extends StatelessWidget {
  final String? text;
  const CustomTextViewer({Key? key , required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child:Text( text !,
          style: const TextStyle(fontFamily: 'cairo'),
        ),
      ),
    );
  }
}
