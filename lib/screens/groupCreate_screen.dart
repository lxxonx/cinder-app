import 'package:flutter/material.dart';
import 'package:mocozi/components/friend_item.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class GroupCreateScreen extends StatelessWidget {
  final FriendController _friendController = FriendController.to;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("search box"),
        Obx(
          () => Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white),
                margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
                padding: EdgeInsets.all(4),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FriendItem(
                      friend: _friendController.friendsList[index],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: const Text(
                          '그룹 만들기',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: _friendController.friendsList.length,
            ),
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: const Center(
              child: Text(
                "그룹만들기",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () {
            // login
            // Get.toNamed("/verifyPhone");
          },
        ),
      ],
    );
  }
}
