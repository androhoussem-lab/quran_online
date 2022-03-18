import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? labelText;
  final Color? color;
  final String? Function(String?)? validator;




  const CustomTextFormField({
    Key? key ,
    required this.enabled,
    required this.controller ,
    required this.maxLength ,
    required this.keyboardType ,
    required this.obscureText,
    required this.labelText,
    required this.color,
    required this.validator,


  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText!,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        label: Text(widget.labelText!),
        labelStyle: TextStyle(
          letterSpacing: 1.5,
            fontFamily: 'cairo',
            color: widget.color),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2,
              color: widget.color!),
        ),
      ),
      validator: widget.validator
    );
  }
}

