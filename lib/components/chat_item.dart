import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/controllers/message_controller.dart';
import 'package:mocozi/model/chat_room.dart';
import 'package:mocozi/pages/chatRoom_page.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
            child: Row(
          children: [
            CircleAvatar(
              foregroundImage:
                  NetworkImage(chatRoom.participants[0].user.avatar),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   chatRoom.uid,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 24.0,
                //     letterSpacing: -1,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    chatRoom.lastMessage.isNotEmpty
                        ? chatRoom.lastMessage[0].message
                        : "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )
              ],
            )
          ],
        )),
      ),
      onTap: () {
        Get.to(
          ChatRoomPage(roomName: chatRoom.uid),
          transition: Transition.rightToLeft,
          curve: Curves.easeInCirc,
        );
        // move to chat
      },
    );
  }
}
