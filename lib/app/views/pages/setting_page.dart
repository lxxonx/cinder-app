import 'package:get/get.dart';
import 'package:mocozi/resources/auth_methods.dart';
import 'package:mocozi/widgets/textOpacityButton.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  void logout() {
    AuthMethods().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            child: Text("완료"),
            onPressed: () => Get.back(),
          ),
        ],
        title: const Text("설정", style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
            TextOpacityButton(
              onPressed: () {
                logout();
                Navigator.pushNamed(context, "/login");
              },
              text: "logout",
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
