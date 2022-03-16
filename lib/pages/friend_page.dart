import 'package:MOCOZI/components/opacity_button.dart';
import 'package:MOCOZI/controllers/friend_controller.dart';
import 'package:MOCOZI/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendPage extends StatelessWidget {
  FriendPage({Key? key}) : super(key: key);
  final FriendController _friendController = FriendController.to;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        title: Container(
            padding: EdgeInsets.zero,
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                      child: OpacityButton(
                          color: _friendController.currentIndex.value == 0
                              ? primaryColor
                              : Colors.black,
                          text: "group",
                          onPressed: () =>
                              _friendController.changeTap("group"))),
                  Expanded(
                      child: OpacityButton(
                    text: "friends",
                    color: _friendController.currentIndex.value == 1
                        ? primaryColor
                        : Colors.black,
                    onPressed: () => _friendController.changeTap("friends"),
                  )),
                ],
              ),
            )),
      ),
      body: Obx(
          () => _friendController.pages[_friendController.currentIndex.value]),
    );
  }
}
