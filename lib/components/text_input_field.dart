import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      this.label = "",
      required this.keyboardType})
      : super(key: key);

  String hintText;
  TextEditingController controller;
  bool obscureText;
  TextInputType keyboardType;
  String label;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(label)),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
        ],
      ),
    );
  }
}
