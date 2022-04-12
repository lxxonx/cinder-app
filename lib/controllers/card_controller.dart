import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mocozi/model/group.dart';
import 'package:mocozi/screens/groupCard_screen.dart';
import 'package:mocozi/screens/group_screen.dart';
import 'package:mocozi/screens/memberInfo_screen.dart';
import 'package:mocozi/screens/member_screen.dart';

class CardController extends GetxController {
  CardController({Key? key, required this.group});
  GlobalKey key = GlobalKey();

  final currentIndex = 0.obs;
  late Group group;
  late List<Widget> pages = [];
  late List<Widget> info = [];

  @override
  void onInit() {
    super.onInit();
    pages = [
      GroupCardScreen(group: group),
    ];
    var memWidget = group.members.map((u) {
      return MemberCardScreen(user: u);
    }).toList();
    pages.addAll(memWidget);
    info = [
      GestureDetector(
          onTap: () {
            // Navigator.of(context).push(_openDetail());
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
                            child: Text(group.groupname,
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
                  group.bio!,
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

    var memInfos = group.members.map((m) {
      // return MemberInfoScreen(user: m);
    }).toList();
    // info.addAll(memInfos);
  }

  Widget get currentPage => pages[currentIndex.value];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      currentIndex.value++;
    } else {
      HapticFeedback.lightImpact();
    }
  }

  void prevPage() {
    if (currentIndex > 0) {
      currentIndex.value--;
    } else {
      HapticFeedback.lightImpact();
    }
  }
}
