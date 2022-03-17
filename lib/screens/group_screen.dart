import 'package:flutter/material.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class GroupScreen extends StatelessWidget {
  final FriendController _friendController = FriendController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_friendController.isLoading.value) {
        return Center(
          child: Text('loading'),
        );
      }
      if (_friendController.myGroups.isEmpty) {
        return Center(
          child: Text('No chat'),
        );
      }
      return ListView.builder(
        itemBuilder: (context, index) => Text(
          _friendController.myGroups[index].groupname,
          // friend: _friendController.friendsList[index],
        ),
        itemCount: _friendController.myGroups.length,
      );
    });
  }
}
