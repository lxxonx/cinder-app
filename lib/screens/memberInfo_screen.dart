import 'package:flutter/material.dart';
import 'package:mocozi/model/user.dart';
import 'package:get/get.dart';
import 'package:mocozi/pages/detail_page.dart';

class MemberInfoScreen extends StatelessWidget {
  const MemberInfoScreen(
      {Key? key, required this.user, required this.toDetailPage})
      : super(key: key);
  final User user;
  final Function toDetailPage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          toDetailPage();
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
                          child: Text("${user.uni}/${user.dep}",
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
                user.bio!,
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
