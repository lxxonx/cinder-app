import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/createGroup_controller.dart';
import 'package:mocozi/app/controller/edit_controller.dart';
import 'package:mocozi/app/views/components/long_texbox.dart';
import 'package:mocozi/app/views/components/textbox.dart';
import 'package:mocozi/utils/colors.dart';

class CreateGroupPage extends StatelessWidget {
  CreateGroupPage({
    Key? key,
  }) : super(key: key);
  final CreateGroupController createGroupController =
      Get.put(CreateGroupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        actions: [
          TextButton(
            child: Text("완료", style: TextStyle(color: primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text("EDIT", style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          Text("새로운 그룹을 만들어 보세요"),
        ],
      ),
    );
  }
}
