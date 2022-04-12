import 'package:flutter/material.dart';
import 'package:mocozi/components/swipe_card.dart';
import 'package:mocozi/components/swipeable_card.dart';
import 'package:mocozi/controllers/group_controller.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class CardScreen extends StatelessWidget {
  final GroupController _groupController = GroupController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_groupController.isLoading.value == true)
        return Center(child: CircularProgressIndicator());
      if (_groupController.groupList.isEmpty) {
        return Center(child: Text("볼 그룹이 없습니다🥲"));
      }
      if (_groupController.hasMore.value == false) {
        return Center(child: Text("볼 그룹이 없습니다🥲"));
      }

      return Container(
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 40),
        padding: const EdgeInsets.only(bottom: 8, top: 0, left: 8, right: 8),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4))),
        child: SwipeCards(
          matchEngine: _groupController.matchEngine,
          itemBuilder: (BuildContext context, int index) {
            // return Container(
            //   color: Colors.blue,
            //   alignment: Alignment.center,
            //   child: Text(
            //     _groupController.groupList[index].groupname,
            //     style: TextStyle(fontSize: 100),
            //   ),
            // );
            return SwipeCard(
                key: UniqueKey(), card: _groupController.cards[index]);
          },
          onStackFinished: () {
            print("finished");
            _groupController.fetchGroups();
          },
          itemChanged: (SwipeItem item, int index) {
            print("item: ${item.content.groupname}, index: $index");
          },
          upSwipeAllowed: false,
          fillSpace: false,
        ),
      );
    });
  }
}
