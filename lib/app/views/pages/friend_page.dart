import 'package:get/get.dart';
import 'package:mocozi/app/controller/friend_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/widgets/chatListItem.dart';
import 'package:mocozi/widgets/friendListItem.dart';
import 'package:mocozi/widgets/friendSearchField.dart';
import 'package:mocozi/widgets/textInputField.dart';
import 'package:mocozi/widgets/textOpacityButton.dart';
import 'package:flutter/material.dart';

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
                      child: TextOpacityButton(
                          color: _friendController.currentIndex.value == 0
                              ? primaryColor
                              : Colors.black,
                          text: "group",
                          onPressed: () =>
                              _friendController.changeTap("group"))),
                  Expanded(
                      child: TextOpacityButton(
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
