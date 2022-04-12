import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/controllers/message_controller.dart';
import 'package:mocozi/model/message.dart';
import 'package:mocozi/pages/chatRoom_page.dart';
import 'package:mocozi/utils/colors.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isMine = message.sender!.actualName ==
        AuthController.to.curUser.value!.actualName;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: InkWell(
            child: Row(
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isMine
                ? Container()
                : CircleAvatar(
                    foregroundImage: NetworkImage(message.sender!.avatar),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMine
                      ? Container()
                      : Text(
                          message.sender!.actualName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            letterSpacing: -1,
                          ),
                        ),
                  Container(
                      decoration: BoxDecoration(
                          color: isMine ? primaryColor : Colors.black12,
                          borderRadius: BorderRadius.circular(4)),
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: isMine ? Colors.white : Colors.black,
                        ),
                      ))
                ],
              ),
            )
          ],
        )),
      ),
      onTap: () {
        // move to chat
      },
    );
  }
}
