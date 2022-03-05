import 'package:flutter/material.dart';

/*
FormInputField(
                controller: _url,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInputField extends StatelessWidget {
  FormInputField(
      {required this.controller,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.autofocus = false,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        )),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: /*Palette.focusedinputBorderColor*/ Colors.black45,
              width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: null,
      minLines: minLines,
      validator: validator,
      autofocus: autofocus,
    );
  }
}
