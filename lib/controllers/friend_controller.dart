import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/model/group.dart';
import 'package:mocozi/model/user.dart';
import 'package:mocozi/screens/friend_screen.dart';
import 'package:mocozi/screens/groupCreate_screen.dart';
import 'package:mocozi/screens/group_screen.dart';
import 'package:mocozi/services/remote_service.dart';

class FriendController extends GetxController {
  static FriendController to = Get.find();
  Widget get currentPage => pages[currentIndex.value];

  var isLoading = false.obs;
  var searchLoading = false.obs;
  var hasMore = false.obs;
  final currentIndex = 0.obs;
  late List<Widget> pages;

  TextEditingController searchController = TextEditingController();
  var friendsList = <User>[].obs;
  var requestsList = <User>[].obs;
  var myGroups = <Group>[].obs;
  var searchResult = Rxn<User>();

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
      var friends = await RemoteServices.fetchFriends();
      if (friends.isEmpty) {
      } else {
        friendsList.value = friends;
      }
    } catch (e) {
      print(e);
    }
  }

  void getRequestsList() async {
    try {
      var requests = await RemoteServices.fetchRequests();
      if (requests == null || requests.isEmpty) {
      } else {
        requestsList.value = requests;
      }
    } catch (e) {
      print(e);
    }
  }

  void getMyGroup() async {
    try {
      var myGroup = await RemoteServices.fetchMyGroups();
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
    var _query = searchController.text.trim();
    var friend = await RemoteServices.searchFriend(_query);
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
    var res = await RemoteServices.sendRequest(friendName);
    if (res) {
      Get.snackbar(
        "??????",
        "?????? ????????? ??????????????? ??????????????????.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
      );
      resetResult();
    }
  }

  void acceptFriend(String username) async {
    searchLoading(true);
    var res = await RemoteServices.acceptFriend(username);
    if (res) {
      Get.snackbar(
        "??????",
        "?????? ?????? ??????",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
      );
      requestsList.removeWhere((element) => element.username == username);
      getFriendsList();
    }
    searchLoading(false);
  }

  void deleteFriend(User) {
    Get.dialog(
      AlertDialog(
        title: Text("?????? ??????"),
        content: Text("????????? ?????????????????????????"),
        actions: [
          TextButton(
            child: Text("??????"),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text("??????"),
            onPressed: () {
              RemoteServices.deleteFriend(User.username);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      GroupCreateScreen(),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void deleteMyGroup(groupname) async {
    bool result = await RemoteServices.deleteGroup();

    if (result) {
      Get.snackbar(
        "??????",
        "????????? ?????????????????????.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
      );
      myGroups.removeWhere((element) => element.groupname == groupname);
    } else {
      Get.snackbar("??????", "?????? ????????? ??????????????????. ????????? ?????? ??????????????????",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
