import 'dart:convert';

import 'package:cinder/dummy/users.dart';
import 'package:cinder/models/profileInfo.dart';
import 'package:cinder/widgets/swipeableCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<ProfileInfo> users = [user1, user2, user3];

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
        child: Stack(
          children: users
              .map((user) => SwipeableCard(
                    profileInfo: user,
                    onTapDislike: () => onTapDislike(),
                    onTapLike: () => onTapLike(),
                    onTapSuperlike: () => onTapSuperlike(),
                  ))
              .toList(),
        ));
  }
}
