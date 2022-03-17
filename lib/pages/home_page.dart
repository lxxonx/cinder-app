import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/controllers/nav_controller.dart';
import 'package:mocozi/pages/profile_page.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final NavController _nav = Get.put(NavController());
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
                Get.to(ProfilePage());
              },
            ),
            title: Logo(),
            backgroundColor: secondaryColor,
            elevation: 0,
            actions: [
              IconButton(icon: Icon(Icons.notifications), onPressed: () {})
            ]),
        body: _nav.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _nav.currentIndex.value,
          onTap: _nav.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
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
