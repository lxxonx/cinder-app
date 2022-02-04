import 'package:mocozi/utils/colors.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({Key? key, this.size = 24}) : super(key: key);

  double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      "Mo'cozi",
      style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w800,
          fontFamily: "DoHyeon",
          fontSize: size),
    );
  }
}
