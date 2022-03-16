import 'package:flutter/material.dart';
import 'package:MOCOZI/components/circle_image.dart';
import 'package:MOCOZI/model/user.dart';

class FriendItem extends StatelessWidget {
  FriendItem({
    Key? key,
    required this.friend,
  }) : super(key: key);
  final User friend;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.white),
        child: Row(
          children: [
            friend.avatar == null
                ? const CircleImage(
                    image: AssetImage(
                      "images/avatar.png",
                    ),
                    size: 40,
                  )
                : CircleImage(
                    image: NetworkImage(friend.avatar!),
                    size: 40,
                  ),
            Container(
              child: Text(friend.actualName!),
              margin: const EdgeInsets.only(left: 8),
            )
          ],
        ));
  }
}
