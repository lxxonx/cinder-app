import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/nav_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.person,
              color: primaryColor,
            ),
            onPressed: () {
              // go to profile
              Get.toNamed("/profile");
            },
          ),
          title: Logo(),
          backgroundColor: secondaryColor,
          elevation: 0,
        ),
        body: Get.put(NavController()).currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: Get.put(NavController()).currentIndex.value,
          onTap: Get.put(NavController()).changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: "",
            )
          ],
        ),
      ),
    );
  }
}
