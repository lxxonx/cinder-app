import 'package:mocozi/app/controller/friend_controller.dart';
import 'package:mocozi/app/views/components/swipeable_card.dart';
import 'package:flutter/material.dart';
import 'package:mocozi/widgets/chatListItem.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final FriendController _friendController = FriendController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_friendController.isLoading.value) {
        return Center(
          child: Text('loading'),
        );
      }
      if (_friendController.friendsList.isEmpty) {
        return Center(
          child: Text('No chat'),
        );
      }
      return ListView.builder(
        itemBuilder: (context, index) => ChatListItem(
            // friend: _friendController.friendsList[index],
            ),
        itemCount: _friendController.friendsList.length,
      );
    });
  }
}
