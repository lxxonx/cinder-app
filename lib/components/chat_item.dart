import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MOCOZI/model/chat_room.dart';
import 'package:MOCOZI/pages/chatRoom_page.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 80,
        child: InkWell(
            child: Row(
          children: [
            Container(
                height: 75,
                width: 75,
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToxtcl-1iO_yF8nszUob_EssatZo8c_aZbuwiH_IxKpHXL3iUI03IRkfkUfX0GPwpzsHg&usqp=CAU")),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatRoom.uid,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    letterSpacing: -1,
                  ),
                ),
                Text(chatRoom.lastMessage.message)
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
