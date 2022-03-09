import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/services/group_services.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class CreateGroupController extends GetxController {
  var isLoading = false.obs;
  var members = <String>[].obs;
  TextEditingController bioController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void createGroup() async {
    var groupname = groupNameController.text;
    var bio = bioController.text;
    await GroupServices.createGroup(
        groupname: groupname,
        friendNames: members.value,
        bio: bio,
        pic_url: "");
  }
}
