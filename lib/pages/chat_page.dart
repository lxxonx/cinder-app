import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/components/chat_item.dart';
import 'package:mocozi/components/opacity_button.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/controllers/chat_controller.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/utils/colors.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final ChatController _chatController = Get.put(ChatController());
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
          Obx(() {
            if (_chatController.chatList.length == 0 &&
                FriendController.to.myGroups.length == 0) {
              return const Expanded(
                child: Center(
                  child: Text(
                    "채팅방을 생성하려면\n먼저 그룹을 만들어주세요!\n⚙️",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return Expanded(
                child: ListView.builder(
              itemBuilder: ((context, index) {
                return ChatItem(
                  chatRoom: _chatController.chatList[index],
                );
              }),
              itemCount: _chatController.chatList.length,
            ));
          })
        ],
      ),
    );
  }
}
