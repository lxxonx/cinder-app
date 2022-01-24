import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      required this.keyboardType})
      : super(key: key);

  String hintText;
  TextEditingController controller;
  bool obscureText;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: obscureText,
        keyboardAppearance: Brightness.light,
        keyboardType: keyboardType,
      ),
    );
  }
}
