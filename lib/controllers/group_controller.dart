import 'dart:convert';

import 'package:mocozi/model/group.dart';
import 'package:mocozi/services/remote_service.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  var isLoading = false.obs;
  var hasMore = true.obs;
  var cards = <SwipeItem>[].obs;
  var groupList = <Group>[].obs;
  var currentIndex = 0.obs;
  var matchEngine;
  static GroupController to = Get.find();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void fetchGroups() async {
    try {
      isLoading(true);
      var groups = await RemoteServices.fetchGroups();

      groupList.value = groups;
      if (groups.isEmpty) {
        isLoading(false);
        hasMore(false);
        return;
      }

      // groupList.value = groups;
      List<SwipeItem> _swipeItems = <SwipeItem>[];
      for (int i = 0; i < groups.length; i++) {
        _swipeItems.add(SwipeItem(
            content: groups[i],
            likeAction: () async {
              await RemoteServices.likeGroup(groups[i].groupname);
              print("like");
            },
            nopeAction: () async {
              await RemoteServices.dislikeGroup(groups[i].groupname);
              print("nope");
            },
            onSlideUpdate: (SlideRegion? region) async {
              print("Region $region");
            }));
      }
      matchEngine = MatchEngine(swipeItems: _swipeItems);
      cards.value = _swipeItems;
    } finally {
      isLoading(false);
    }
  }

  void reportGroup(groupname) async {
    bool res = await RemoteServices.reportGroup(groupname);
    Get.snackbar("성공", "신고 완료");
  }
}
