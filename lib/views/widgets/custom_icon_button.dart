import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final double? size;
  final Color? color;

  const CustomIconButton(
      {Key? key,
      required this.onTap,
      required this.icon,
      required this.size,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!,
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
