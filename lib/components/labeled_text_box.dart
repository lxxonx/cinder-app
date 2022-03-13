import 'package:flutter/material.dart';

class LabeledTextBox extends StatelessWidget {
  const LabeledTextBox({
    Key? key,
    this.label = "",
    required this.text,
  }) : super(key: key);
  final label;
  final text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(label)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.fromBorderSide(Divider.createBorderSide(context)),
          ),
          width: double.infinity,
          height: 50,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text,
                style: const TextStyle(fontSize: 16, color: Colors.black54)),
          ),
        ),
      ],
    );
  }
}
