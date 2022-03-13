import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/components/chat_item.dart';
import 'package:mocozi/components/opacity_button.dart';
import 'package:mocozi/utils/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Text("Chat Page",
                style: TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold)),
          ),
          Expanded(child: ListView.builder(itemBuilder: ((context, index) {
            return ChatItem();
          }))),
        ],
      ),
    );
  }
}
