import 'package:cinder/widgets/chatListItem.dart';
import 'package:cinder/widgets/friendListItem.dart';
import 'package:cinder/widgets/friendSearchField.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String tap = "chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Expanded(
                  child: TextButton(
                child: Text("chat"),
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  // onPress chat
                  setState(() {
                    tap = "chat";
                  });
                },
              )),
              Expanded(
                  child: TextButton(
                child: Text("friends"),
                onPressed: () {
                  // onPress chat
                  setState(() {
                    tap = "friends";
                  });
                },
              )),
            ],
          ),
        ),
      ),
      body: (tap == "chat")
          ? ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
                ChatListItem(),
              ],
            )
          : ListView(children: [
              FriendListItem(
                  name: "friend 1",
                  avatarUrl:
                      "https://media.istockphoto.com/vectors/avatar-5-vector-id1131164548?k=20&m=1131164548&s=612x612&w=0&h=ODVFrdVqpWMNA1_uAHX_WJu2Xj3HLikEnbof6M_lccA="),
              FriendListItem(
                  name: "friend 2",
                  avatarUrl:
                      "https://media.istockphoto.com/vectors/avatar-5-vector-id1131164548?k=20&m=1131164548&s=612x612&w=0&h=ODVFrdVqpWMNA1_uAHX_WJu2Xj3HLikEnbof6M_lccA="),
              FriendListItem(
                  name: "friend 3",
                  avatarUrl:
                      "https://media.istockphoto.com/vectors/avatar-5-vector-id1131164548?k=20&m=1131164548&s=612x612&w=0&h=ODVFrdVqpWMNA1_uAHX_WJu2Xj3HLikEnbof6M_lccA="),
            ]),
    );
  }
}
