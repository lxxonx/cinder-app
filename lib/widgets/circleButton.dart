import 'package:flutter/material.dart';

class OutlineCircleButton extends StatelessWidget {
  OutlineCircleButton({
    Key? key,
    this.onPressed,
    this.borderSize: 0.5,
    this.radius: 40.0,
    this.borderColor: Colors.black,
    this.foregroundColor: Colors.transparent,
    this.child,
  }) : super(key: key);

  final onPressed;
  final radius;
  final borderSize;
  final borderColor;
  final foregroundColor;
  final child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              splashColor: borderColor,
              child: child ?? SizedBox(),
              onTap: () async {
                if (onPressed != null) {
                  onPressed();
                }
              }),
        ),
      ),
    );
  }
}
