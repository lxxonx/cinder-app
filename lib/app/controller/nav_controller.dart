import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/views/pages/friend_page.dart';
import 'package:mocozi/pages/explore.dart';
import 'package:mocozi/pages/heart.dart';
import 'package:mocozi/app/views/screens/card_screen.dart';

class NavController extends GetxController {
  final currentIndex = 0.obs;
  static NavController get to => Get.find<NavController>();

  List<Widget> pages = [
    CardScreen(),
    FriendPage(),
    HeartScreen(),
    ExploreScreen(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int _index) {
    currentIndex.value = _index;
  }
}
