import 'package:flutter/material.dart';
import 'package:MOCOZI/components/circle_image.dart';

class CircleProfile extends StatelessWidget {
  const CircleProfile({Key? key, required this.image, this.size = 180})
      : super(key: key);

  final ImageProvider image;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.pink, Colors.pink, Colors.yellow.shade900],
                  stops: const [0, 0.6, 0.9],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Container(
              child: CircleImage(image: image, size: size),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white)),
        ),
        Container(
            width: size - 70,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Colors.pink, Colors.pink, Colors.yellow.shade900],
                  stops: [0, 0.6, 1],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight),
            ),
            child: Center(
                child: Text("60% complete",
                    style: TextStyle(color: Colors.white))))
      ],
    );
  }
}
