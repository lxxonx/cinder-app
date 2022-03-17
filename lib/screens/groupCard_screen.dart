import 'package:flutter/material.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/model/group.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class GroupCardScreen extends StatelessWidget {
  const GroupCardScreen({Key? key, required this.group}) : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    var list = [
      Container(
        width: 450,
        height: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(group.pics[0].url),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(group.bio!),
      ),
      ...group.pics.map((e) {
        if (group.pics.indexOf(e) == 0) return Container();
        return Container(
          width: 450,
          height: 450,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(e.url),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    ];
    return SingleChildScrollView(
        child: Column(
      children: list,
    ));
  }
}
