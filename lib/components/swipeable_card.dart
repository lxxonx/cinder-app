import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MOCOZI/components/outline_circle_button.dart';
import 'package:MOCOZI/controllers/card_controller.dart';
import 'package:MOCOZI/model/group.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeableCard extends StatelessWidget {
  SwipeableCard({Key? key, required this.matchEngine}) : super(key: key);
  final MatchEngine matchEngine;
  @override
  Widget build(BuildContext context) {
    CardController cardController = Get.put(
        CardController(group: matchEngine.currentItem!.content as Group));
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: Obx(() =>
                  cardController.pages[cardController.currentIndex.value])),
          /*
          buttons
         */
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      cardController.prevPage();
                    },
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      cardController.nextPage();
                    },
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() => cardController.info[cardController.currentIndex.value]),
              buttons(),
            ],
          )
        ],
      ),
    );
  }

  Widget buttons() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 0, left: 8, right: 8),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlineCircleButton(
            borderColor: Colors.red,
            borderSize: 2.0,
            radius: 40.0,
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              // undo
              matchEngine.currentItem!.nope();
            },
          ),
          OutlineCircleButton(
            borderColor: Colors.green,
            borderSize: 2.0,
            radius: 40.0,
            child: const Icon(
              Icons.favorite,
              color: Colors.green,
            ),
            onPressed: () {
              // boost
              matchEngine.currentItem!.like();
            },
          ),
        ],
      ),
    );
  }

  // prevPic() {
  //   if (_currentPicIndex > 0) {
  //     setState(() {
  //       _currentPicIndex--;
  //     });
  //   } else {
  //     // move card for nudge;
  //     HapticFeedback.lightImpact();
  //   }
  //   return null;
  // }

  // nextPic() {
  //   if (_currentPicIndex < pics!.length - 1) {
  //     setState(() {
  //       _currentPicIndex++;
  //     });
  //   } else {
  //     // move card for nudge;
  //     HapticFeedback.lightImpact();
  //   }
  //   return null;
  // }

  // Route _openDetail() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
  //       profileInfo: widget.profileInfo,
  //       currentPicIndex: _currentPicIndex,
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
