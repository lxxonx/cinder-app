import 'package:get/get.dart';
import 'package:mocozi/pages/edit.dart';
import 'package:mocozi/pages/settings.dart';
import 'package:mocozi/widgets/circleButton.dart';
import 'package:mocozi/widgets/circleImage.dart';
import 'package:mocozi/widgets/circleProfile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Flexible(child: Container(), flex: 1),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(_openEdit("preview"));
                        Get.off(ProfileEditScreen(state: "preview"));
                      },
                      child: const CircleProfile(
                          image: NetworkImage(
                              "https://www.acumarketing.com/acupuncture-websites/wp-content/uploads/2020/01/anonymous-avatar-sm.jpg")),
                    ),
                    Text(
                      "name",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(child: Container(), flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleButton(
                          onPressed: () {
                            // Navigator.of(context).push(_openSettings());
                            Get.off(SettingsScreen());
                          },
                          child: Icon(Icons.settings),
                        ),
                        CircleButton(
                          onPressed: () {
                            // Navigator.of(context).push(_openEdit("edit"));
                            Get.off(ProfileEditScreen(state: "edit"));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Flexible(child: Container(), flex: 2),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Container(
                  color: Colors.blueGrey,
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: Text("광고 자리"))),
            )
          ],
        ),
      ),
    );
  }
}
