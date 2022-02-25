import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mocozi/pages/chat.dart';
import 'package:mocozi/pages/explore.dart';
import 'package:mocozi/pages/heart.dart';
import 'package:mocozi/app/views/screens/card_screen.dart';

class NavController extends GetxController {
  final currentIndex = 0.obs;

  List<Widget> pages = [
    CardScreen(),
    ExploreScreen(),
    HeartScreen(),
    ChatScreen()
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int _index) {
    currentIndex.value = _index;
  }
}
