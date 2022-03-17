import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/model/chat_room.dart';
import 'package:mocozi/services/remote_service.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find<ChatController>();

  var chatList = <ChatRoom>[].obs;

  @override
  void onInit() {
    super.onInit();
    getChatList();
  }

  void getChatList() async {
    var chats = await RemoteServices.fetchChatList();
    if (chats != null) {
      chatList.value = chats;
    }
  }
}
