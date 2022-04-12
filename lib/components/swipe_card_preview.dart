import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mocozi/components/opacity_button.dart';
import 'package:mocozi/components/outline_circle_button.dart';
import 'package:mocozi/controllers/card_controller.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/model/group.dart';
import 'package:mocozi/pages/detail_page.dart';
import 'package:mocozi/pages/detail_preview_page.dart';
import 'package:mocozi/screens/groupCard_screen.dart';
import 'package:mocozi/screens/memberInfo_screen.dart';
import 'package:mocozi/screens/member_screen.dart';
import 'package:mocozi/services/remote_service.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeCardPreview extends StatefulWidget {
  SwipeCardPreview({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _SwipeCardPreviewState createState() => _SwipeCardPreviewState();
}

class _SwipeCardPreviewState extends State<SwipeCardPreview> {
  int _currentPageIndex = 0;
  List<Widget> pages = [];
  List<Widget> info = [];

  @override
  void initState() {
    super.initState();
    pages = [
      GroupCardScreen(group: widget.group),
    ];
    var memWidget = widget.group.members.map<Widget>((u) {
      return MemberCardScreen(user: u);
    }).toList();
    pages.addAll(memWidget);
    info = [
      GestureDetector(
          onTap: () {
            // Navigator.of(context).push(_openDetail());
            Get.to(DetailPreviewPage(key: UniqueKey(), group: widget.group));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black])),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        // Text(widget.profileInfo.username,
                        //     style: const TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 32.0,
                        //         fontWeight: FontWeight.w600)),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Text(widget.group.groupname,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                  ],
                ),
                Text(
                  widget.group.bio!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                // Text(widget.profileInfo.bio,
                //     style: TextStyle(color: Colors.white))
              ],
            ),
          )),
    ];

    var memInfos = widget.group.members.map<Widget>((m) {
      return MemberInfoScreen(
        user: m,
        toDetailPage: () =>
            Get.to(DetailPreviewPage(key: UniqueKey(), group: widget.group)),
      );
    }).toList();
    info.addAll(memInfos);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: pages[_currentPageIndex]),
          /*
          buttons
         */
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      prevPage();
                    },
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      nextPage();
                    },
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                child: OpacityButton(
                  text: "그룹 삭제",
                  onPressed: () async {
                    FriendController.to.deleteMyGroup(widget.group.groupname);
                  },
                  color: Colors.red,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              info[_currentPageIndex],
              // buttons(),
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
              // widget.card.nope();
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
              // widget.card.like();
            },
          ),
        ],
      ),
    );
  }

  prevPage() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
      });
    } else {
      // move card for nudge;
      HapticFeedback.lightImpact();
    }
    return null;
  }

  nextPage() {
    if (_currentPageIndex < pages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    } else {
      // move card for nudge;
      HapticFeedback.lightImpact();
    }
    return null;
  }

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
