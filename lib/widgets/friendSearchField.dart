import 'package:flutter/material.dart';

class FriendSearchField extends StatefulWidget {
  FriendSearchField({Key? key}) : super(key: key);

  @override
  _FriendSearchFieldState createState() => _FriendSearchFieldState();
}

class _FriendSearchFieldState extends State<FriendSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(8),
      child: TextField(),
    );
  }
}
