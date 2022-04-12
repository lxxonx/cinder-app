import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/model/group.dart';
import 'package:mocozi/model/user.dart';
import 'package:mocozi/services/remote_service.dart';

class GroupCreateController extends GetxController {
  var isLoading = false.obs;
  var sendingRequest = false.obs;
  var currentIndex = 0.obs;
  var checked = <User>[].obs;
  var pics = <Pic>[].obs;
  var assets = <XFile>[].obs;
  var searchMyFriendsList = <User>[].obs;

  static GroupCreateController get to => Get.find();

  TextEditingController friendNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void createGroup() async {
    isLoading(true);
    var groupname = nameController.text;
    if (groupname.isEmpty) {
      Get.snackbar("오류", "그룹 이름을 입력해주세요");
      return;
    }
    if (checked.isEmpty) {
      Get.snackbar("오류", "적어도 한 명의 친구를 선택해주세요");
      return;
    }
    var res = await RemoteServices.createGroup(
      checked.map((u) => u.username!).toList(),
      groupname,
      bioController.text,
      assets,
    );

    if (res) {
      FriendController.to.getMyGroup();
      Get.back();
    }

    isLoading(false);
    // if (res != null) {
    //   FriendController.to.myGroups.add(res);
    // }
  }

  // void uploadPic(_pickedFile) async {
  //   isLoading(true);
  //   var pic = await RemoteServices.uploadPic(_pickedFile);
  //   if (pic != null) {
  //     pics.add(pic);
  //   }
  //   isLoading(false);
  // }

  void deletePic(index) async {
    isLoading(true);
    // await Re
    assets.removeAt(index);
    isLoading(false);
  }

  void searchMyFriends() async {
    var _query = friendNameController.text.trim();
    if (_query.isEmpty) {
      return;
    }
    RemoteServices.searchMyFriends(_query).then((res) {
      if (res != null) {
        searchMyFriendsList.addAll(res);
      }
    });
  }
}
