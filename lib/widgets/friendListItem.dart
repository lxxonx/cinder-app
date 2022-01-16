import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({Key? key, required this.name, required this.avatarUrl})
      : super(key: key);

  final String name;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.white),
        margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
        padding: EdgeInsets.all(4),
        child: Row(
          children: [
            Image.network(
              avatarUrl,
              height: 40,
              width: 40,
            ),
            Container(
              child: Text(name),
              margin: EdgeInsets.only(left: 8),
            )
          ],
        ));
  }
}
