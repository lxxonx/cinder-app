import 'package:flutter/material.dart';
import 'package:mocozi/app/models/friend.dart';

class FriendItem extends StatelessWidget {
  FriendItem({
    Key? key,
    required this.friend,
  }) : super(key: key);
  final Friend friend;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.white),
        child: Row(
          children: [
            friend.avatar == null
                ? Image.asset(
                    "images/avatar.png",
                    height: 40,
                    width: 40,
                  )
                : Image.network(
                    friend.avatar!,
                    height: 40,
                    width: 40,
                  ),
            Container(
              child: Text(friend.actualName),
              margin: EdgeInsets.only(left: 8),
            )
          ],
        ));
  }
}
