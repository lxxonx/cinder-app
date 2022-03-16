import 'package:MOCOZI/components/opacity_button.dart';
import 'package:MOCOZI/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void logout() {
    AuthController.to.signOut();
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
            OpacityButton(
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
