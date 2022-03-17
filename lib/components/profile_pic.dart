import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key, required this.pic, required this.onPressed})
      : super(key: key);

  final String pic;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 180,
      width: 150,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(pic),
                fit: BoxFit.cover,
              ),
            ),
          ),
          IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.close),
              color: Colors.black),
        ],
      ),
    );
  }
}
