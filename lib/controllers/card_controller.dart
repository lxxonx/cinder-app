import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/model/group.dart';

class CardController extends GetxController {
  CardController({Key? key, required this.group});

  final currentIndex = 0.obs;
  late Group group;
  late List<Widget> pages = [];
  late List<Widget> info = [];
  void onInit() {
    super.onInit();

    pages = [
      ListView(
        children: [
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
        ],
      ),
    ];
    group.members.map((m) {
      return ListView(
        children: [
          Container(
            width: 450,
            height: 450,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(m.pics[0]),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
        ],
      );
    }).toList();

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
  }

  Widget get currentPage => pages[currentIndex.value];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      currentIndex.value++;
    }
  }

  void prevPage() {
    if (currentIndex > 0) {
      currentIndex.value--;
    }
  }
}
