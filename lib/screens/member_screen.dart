import 'package:flutter/material.dart';
import 'package:MOCOZI/controllers/friend_controller.dart';
import 'package:MOCOZI/model/group.dart';
import 'package:MOCOZI/model/user.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class MemberCardScreen extends StatelessWidget {
  const MemberCardScreen({Key? key, required this.member}) : super(key: key);
  final Member member;

  @override
  Widget build(BuildContext context) {
    var list = [
      Container(
        width: 450,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(member.users.pics![0].url.split(".jpg")[0] +
                "_8.jpg?alt=media"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(member.users.bio!),
      ),
      ...member.users.pics!.map((e) {
        return Container(
          width: 450,
          height: 450,
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: NetworkImage(e.url.split(".jpg")[0] + "_8.jpg?alt=media"),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    ];
    return SingleChildScrollView(
        child: Column(
            // children: list,
            ));
  }
}
