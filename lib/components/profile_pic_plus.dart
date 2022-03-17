import 'package:flutter/material.dart';
import 'package:mocozi/utils/colors.dart';

class ProfilePicPlus extends StatelessWidget {
  const ProfilePicPlus({Key? key, required this.onPressed}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 180,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor, width: 2),
        ),
        child: Center(child: Icon(Icons.add, size: 50, color: primaryColor)),
      ),
    );
  }
}
