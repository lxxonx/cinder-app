import 'package:mocozi/utils/colors.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({Key? key, this.size = 24, this.color = primaryColor}) : super(key: key);

  double size;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      "Mo'cozi",
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontFamily: "DoHyeon",
          fontSize: size),
    );
  }
}
