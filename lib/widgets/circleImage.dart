import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    Key? key,
    required this.imgUrl,
    this.size = 180,
  }) : super(key: key);

  final String imgUrl;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.contain, image: NetworkImage(imgUrl))),
    );
  }
}
