import 'package:flutter/material.dart';
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
        return Center(child: Text("No Groups"));
      }
      var _matchEngine = MatchEngine(
        swipeItems: _groupController.cards,
      );
      return Container(
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 40),
        padding: const EdgeInsets.only(bottom: 8, top: 0, left: 8, right: 8),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4))),
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (BuildContext context, int index) {
            // return Container(
            //   color: Colors.blue,
            //   alignment: Alignment.center,
            //   child: Text(
            //     _cardController.groupList[index].groupname,
            //     style: TextStyle(fontSize: 100),
            //   ),
            // );
            return SwipeableCard(
                key: UniqueKey(), card: _groupController.cards[index]);
          },
          onStackFinished: () {
            print("finished");
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
