import 'package:flutter/material.dart';
import 'package:mocozi/components/opacity_button.dart';
import 'package:mocozi/components/swipe_card.dart';
import 'package:mocozi/components/swipe_card_preview.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class GroupScreen extends StatelessWidget {
  final FriendController _friendController = FriendController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_friendController.myGroups.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('아직 만들어진 그룹이 없네요'),
            ),
            OpacityButton(
              onPressed: () {
                _friendController.openBottomSheet();
              },
              text: "지금 바로 만들어 볼까요?😆",
              color: primaryColor,
              fontSize: 14,
            )
          ],
        );
      } else {
        return SwipeCardPreview(group: _friendController.myGroups[0]);
      }
      // return ListView.builder(
      //   itemBuilder: (context, index) => Text(
      //     _friendController.myGroups[index].groupname,
      //     // friend: _friendController.friendsList[index],
      //   ),
      //   itemCount: _friendController.myGroups.length,
      // );
    });
  }
}
