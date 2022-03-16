import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MOCOZI/pages/chat_page.dart';
import 'package:MOCOZI/pages/friend_page.dart';
import 'package:MOCOZI/pages/heart_page.dart';
import 'package:MOCOZI/screens/card_screen.dart';

class NavController extends GetxController {
  final currentIndex = 0.obs;
  static NavController get to => Get.find<NavController>();

  List<Widget> pages = [
    CardScreen(),
    FriendPage(),
    HeartPage(),
    ChatPage(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int _index) {
    currentIndex.value = _index;
  }
}
