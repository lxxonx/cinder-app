import 'dart:convert';

import 'package:mocozi/dummy/users.dart';
import 'package:mocozi/models/profileInfo.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/widgets/outlineCircleButton.dart';
import 'package:mocozi/widgets/swipeableCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<ProfileInfo> users = [user1, user2, user3];

  @override
  bool get wantKeepAlive => true;

  onTapLike() {
    print("liked");
    nextCard();
  }

  onTapDislike() {
    print("dislike");
    nextCard();
  }

  onTapSuperlike() {
    print("superlike");
    nextCard();
  }

  nextCard() {
    // show next card
    setState(() {
      users.removeLast();
    });
    // fetch another one
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 40),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          ...users
              .map((user) => SwipeableCard(
                    profileInfo: user,
                    onTapDislike: () => onTapDislike(),
                    onTapLike: () => onTapLike(),
                    onTapSuperlike: () => onTapSuperlike(),
                  ))
              .toList(),
          buttons(),
        ]));
  }

  Widget buttons() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 0, left: 8, right: 8),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // OutlineCircleButton(
          //   borderColor: Colors.yellow,
          //   borderSize: 1.0,
          //   radius: 40.0,
          //   child: const Icon(
          //     Icons.ac_unit,
          //     color: Colors.yellow,
          //   ),
          //   onPressed: () {
          //     // undo
          //   },
          // ),
          OutlineCircleButton(
              borderColor: Colors.red,
              borderSize: 1.0,
              radius: 50.0,
              child: const Icon(
                Icons.not_interested,
                color: Colors.red,
              ),
              onPressed: () => onTapDislike()),
          OutlineCircleButton(
              borderColor: Colors.blue,
              borderSize: 1.0,
              radius: 40.0,
              child: const Icon(
                Icons.star,
                color: Colors.blue,
              ),
              onPressed: () => onTapSuperlike()),
          OutlineCircleButton(
              borderColor: Colors.green,
              borderSize: 1.0,
              radius: 50.0,
              child: const Icon(
                Icons.favorite,
                color: Colors.green,
              ),
              onPressed: () => onTapLike()),
          // OutlineCircleButton(
          //   borderColor: Colors.purple,
          //   borderSize: 1.0,
          //   radius: 40.0,
          //   child: const Icon(
          //     Icons.ac_unit,
          //     color: Colors.purple,
          //   ),
          //   onPressed: () {
          //     // boost
          //   },
          // ),
        ],
      ),
    );
  }
}
