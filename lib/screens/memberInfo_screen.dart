import 'package:flutter/material.dart';
import 'package:mocozi/model/group.dart';

class MemberInfoScreen extends StatelessWidget {
  const MemberInfoScreen({Key? key, required this.member}) : super(key: key);
  final Member member;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          child: Text(
                              "${member.users.uni!}/${member.users.dep!}",
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
                member.users.bio!,
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              // Text(widget.profileInfo.bio,
              //     style: TextStyle(color: Colors.white))
            ],
          ),
        ));
  }
}
