import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/components/chat_item.dart';
import 'package:mocozi/components/text_input_field.dart';
import 'package:mocozi/controllers/message_controller.dart';
import 'package:mocozi/utils/colors.dart';

class ChatRoomPage extends StatelessWidget {
  ChatRoomPage({Key? key, required this.roomName}) : super(key: key);
  final String roomName;

  final MessageController _messageController = Get.put(MessageController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar:
          AppBar(title: Text(roomName, style: TextStyle(color: primaryColor))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Text("Chat room ${roomName}",
                style: TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold)),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: ((context, index) {
              return Text("hello");
            }),
            reverse: true,
          )),
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 40,
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller: _messageController.textEditingController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Center(
                        child: _messageController.isLoading.value == true
                            ? const CircularProgressIndicator()
                            : const Text(
                                "보내기",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    onTap: () {
                      // call signUp func
                      _messageController.sendMessage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
