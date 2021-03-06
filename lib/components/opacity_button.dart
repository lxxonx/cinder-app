import 'package:mocozi/utils/colors.dart';
import 'package:flutter/material.dart';

class OpacityButton extends StatefulWidget {
  OpacityButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.height,
    this.width,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  double? height;
  double? width;
  @override
  State<OpacityButton> createState() => _OpacityButtonState();
}

class _OpacityButtonState extends State<OpacityButton> {
  @override
  void initState() {
    super.initState();
  }

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        height: widget.height,
        width: widget.width,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.color.withAlpha(pressed ? 127 : 255),
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
          ),
        ),
      ),
      onHighlightChanged: (value) {
        setState(() {
          pressed = value;
        });
      },
    );
  }
}
