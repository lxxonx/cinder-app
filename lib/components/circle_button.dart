import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      this.color = Colors.white,
      this.size = 60,
      required this.onPressed,
      required this.child})
      : super(key: key);

  final Color color;
  final double size;
  final onPressed;
  final child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed(),
        child: Container(
          width: size,
          height: size,
          child: Center(
            child: child,
          ),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 1),
            )
          ]),
        ));
  }
}
