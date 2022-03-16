import 'package:get/state_manager.dart';
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
        return;
      }

      // groupList.value = groups;
      List<SwipeItem> _swipeItems = <SwipeItem>[];
      for (Group group in groups) {
        print(group.pics.length);
        _swipeItems.add(SwipeItem(
            content: group,
            likeAction: () async {
              await RemoteServices.likeGroup(group.groupname);
              print("like");
            },
            nopeAction: () async {
              await RemoteServices.dislikeGroup(group.groupname);
              print("nope");
            },
            onSlideUpdate: (SlideRegion? region) async {
              print("Region $region");
            }));
      }
      cards.value = _swipeItems;
    } finally {
      isLoading(false);
    }
  }
}
