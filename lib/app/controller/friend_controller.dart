import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/models/friend.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/models/user.dart';
import 'package:mocozi/app/services/friend_services.dart';
import 'package:mocozi/app/services/group_services.dart';
import 'package:mocozi/app/views/screens/friend_screen.dart';
import 'package:mocozi/app/views/screens/group_screen.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();
  Widget get currentPage => pages[currentIndex.value];

  var isLoading = false.obs;
  var searchLoading = false.obs;
  var hasMore = false.obs;
  final currentIndex = 0.obs;
  late List<Widget> pages;

  TextEditingController searchController = TextEditingController();
  var friendsList = <Friend>[].obs;
  var requestsList = <Friend>[].obs;
  var myGroups = <Group>[].obs;
  var searchResult = Rxn<Friend>();

  @override
  void onReady() {
    super.onReady();
    pages = [
      GroupScreen(),
      FriendScreen(),
    ];
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTap(String _tapName) {
    switch (_tapName) {
      case "group":
        currentIndex.value = 0;
        break;

      default:
        // case "friends":
        currentIndex.value = 1;
        break;
    }
  }

  void getFriendsList() async {
    try {
      var friends = await FriendServices.fetchFriends();
      if (friends == null || friends.isEmpty) {
      } else {
        friendsList.value = friends;
      }
    } catch (e) {
      print(e);
    }
  }

  void getRequestsList() async {
    try {
      var requests = await FriendServices.getRequest();
      if (requests == null || requests.isEmpty) {
      } else {
        requestsList.value = requests;
      }
      print(requests);
    } catch (e) {
      print(e);
    }
  }

  void getMyGroup() async {
    try {
      var myGroup = await GroupServices.getMyGroup();
      if (myGroup == null || myGroup.isEmpty) {
      } else {
        myGroups.value = myGroup;
      }
    } catch (e) {
      print(e);
    }
  }

  void searchFriend() async {
    searchLoading(true);
    var _query = searchController.text;
    var friend = await FriendServices.searchFriends(_query);
    if (friend == null) {
      searchResult.value = null;
    } else {
      searchResult.value = friend;
    }
    searchLoading(false);
  }

  void resetResult() {
    searchResult.value = null;
    searchController.text = "";
  }

  void sendRequest(friendName) async {
    var res = await FriendServices.sendRequest(friendName);
    if (res) {
      Get.snackbar(
        "성공",
        "친구 요청이 성공적으로 보내졌습니다.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
      );
      resetResult();
    }
  }

  void acceptFriend(String username) async {
    searchLoading(true);
    var res = await FriendServices.acceptFriend(username);
    if (res) {
      Get.snackbar(
        "성공",
        "친구 추가 완료",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
      );
      requestsList.removeWhere((element) => element.username == username);
      getFriendsList();
    }
    searchLoading(false);
  }
}
