import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/widgets/chatListItem.dart';
import 'package:mocozi/widgets/friendListItem.dart';
import 'package:mocozi/widgets/friendSearchField.dart';
import 'package:mocozi/widgets/textInputField.dart';
import 'package:mocozi/widgets/textOpacityButton.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  String tap = "chat";
  final TextEditingController _friendInputController = TextEditingController();
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                  child: TextOpacityButton(
                color: tap == "chat" ? primaryColor : Colors.black,
                text: "chat",
                onPressed: () {
                  // onPress chat
                  setState(() {
                    tap = "chat";
                  });
                },
              )),
              Expanded(
                  child: TextOpacityButton(
                text: "friends",
                color: tap == "friends" ? primaryColor : Colors.black,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                height: 50,
                child: TextField(
                  controller: _friendInputController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search Your Friend",
                    contentPadding: EdgeInsets.only(left: 12),
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    errorBorder: inputBorder,
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
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
