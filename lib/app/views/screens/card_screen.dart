import 'dart:convert';

import 'package:mocozi/app/controller/card_controller.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/views/components/swipeable_card.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/widgets/outlineCircleButton.dart';
import 'package:mocozi/widgets/swipeableCard.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen>
//     with AutomaticKeepAliveClientMixin {
//   List<ProfileInfo> users = [user1, user2, user3];

//   @override
//   bool get wantKeepAlive => true;

//   onTapLike() {
//     print("liked");
//     nextCard();
//   }

//   onTapDislike() {
//     print("dislike");
//     nextCard();
//   }

//   onTapSuperlike() {
//     print("superlike");
//     nextCard();
//   }

//   nextCard() {
//     // show next card
//     setState(() {
//       users.removeLast();
//     });
//     // fetch another one
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.fromLTRB(5, 20, 5, 40),
//         child: Stack(alignment: Alignment.bottomCenter, children: [
//           ...users
//               .map((user) => SwipeableCard(
//                     profileInfo: user,
//                     onTapDislike: () => onTapDislike(),
//                     onTapLike: () => onTapLike(),
//                     onTapSuperlike: () => onTapSuperlike(),
//                   ))
//               .toList(),
//           buttons(),
//         ]));
//   }

//   Widget buttons() {
//     return Container(
// child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           // OutlineCircleButton(
//           //   borderColor: Colors.yellow,
//           //   borderSize: 1.0,
//           //   radius: 40.0,
//           //   child: const Icon(
//           //     Icons.ac_unit,
//           //     color: Colors.yellow,
//           //   ),
//           //   onPressed: () {
//           //     // undo
//           //   },
//           // ),
//           OutlineCircleButton(
//               borderColor: Colors.red,
//               borderSize: 1.0,
//               radius: 50.0,
//               child: const Icon(
//                 Icons.not_interested,
//                 color: Colors.red,
//               ),
//               onPressed: () => onTapDislike()),
//           OutlineCircleButton(
//               borderColor: Colors.blue,
//               borderSize: 1.0,
//               radius: 40.0,
//               child: const Icon(
//                 Icons.star,
//                 color: Colors.blue,
//               ),
//               onPressed: () => onTapSuperlike()),
//           OutlineCircleButton(
//               borderColor: Colors.green,
//               borderSize: 1.0,
//               radius: 50.0,
//               child: const Icon(
//                 Icons.favorite,
//                 color: Colors.green,
//               ),
//               onPressed: () => onTapLike()),
//           // OutlineCircleButton(
//           //   borderColor: Colors.purple,
//           //   borderSize: 1.0,
//           //   radius: 40.0,
//           //   child: const Icon(
//           //     Icons.ac_unit,
//           //     color: Colors.purple,
//           //   ),
//           //   onPressed: () {
//           //     // boost
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }

class CardScreen extends StatelessWidget {
  final CardController _cardController = Get.put(CardController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_cardController.isLoading.value == true ||
          _cardController.groupList.value.length == 0)
        return Center(child: CircularProgressIndicator());
      else {
        var _matchEngine = MatchEngine(
          swipeItems: _cardController.cards,
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
              return SwipeCard();
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
      }
    });
  }
}
