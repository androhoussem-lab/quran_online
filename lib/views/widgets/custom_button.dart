import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color? color;

  const CustomButton(
      {Key? key,
        required this.onPressed,
        required this.text,
        required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minWidth: MediaQuery.of(context).size.width,
      height: 50,
      child: Text(
        text!,
        style: const TextStyle(
            fontFamily: 'cairo',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          letterSpacing: 2
        ),
      ),

    );
  }
}
