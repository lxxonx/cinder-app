import 'package:flutter/material.dart';

class OutlineCircleButton extends StatefulWidget {
  const OutlineCircleButton({
    Key? key,
    required this.onPressed,
    this.borderSize = 0.5,
    this.radius = 40.0,
    this.borderColor = Colors.black,
    this.foregroundColor = Colors.transparent,
    this.child,
  }) : super(key: key);

  final Function() onPressed;
  final radius;
  final borderSize;
  final borderColor;
  final foregroundColor;
  final child;
  @override
  State<OutlineCircleButton> createState() => _OutlineCircleButtonState();
}

class _OutlineCircleButtonState extends State<OutlineCircleButton> {
  @override
  void initState() {
    super.initState();
    size = widget.radius;
  }

  double size = 40.0;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border:
              Border.all(color: widget.borderColor, width: widget.borderSize),
          color: widget.foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: widget.borderColor,
            child: widget.child ?? SizedBox(),
            onTap: widget.onPressed,
            onHighlightChanged: (value) {
              setState(() {
                pressed = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
