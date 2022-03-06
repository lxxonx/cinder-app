import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LongTextBox extends StatelessWidget {
  LongTextBox({Key? key, required this.controller, this.label = ""})
      : super(key: key);
  final TextEditingController controller;
  String label;
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
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            minLines: 3,
            maxLines: 3,
            maxLength: 200,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
          ),
        ),
      ],
    );
  }
}
