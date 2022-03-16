import 'package:flutter/material.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/components/long_text_box.dart';
import 'package:mocozi/components/text_input_field.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/controllers/groupCreate_controller.dart';
import 'package:mocozi/model/user.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';

class GroupCreatePage extends StatelessWidget {
  GroupCreatePage({Key? key}) : super(key: key);
  final GroupCreateController _groupCreateController = GroupCreateController.to;
  Widget build(BuildContext context) {
    print(_groupCreateController.checked);
    return Scaffold(
      appBar: AppBar(
        title: Container(padding: EdgeInsets.all(20), child: Logo(size: 32)),
      ),
      body: SafeArea(
          child: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Text("함께할 친구들"),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(
                            _groupCreateController.checked[0].avatar!),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("그룹 커버 사진"),
                    ),
                    SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var len = _groupCreateController.pics.length;

                            if (index < len) {
                              return Container(
                                height: 180,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _groupCreateController.pics[index].url,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    openDialog();
                                  },
                                  child: Container(
                                      height: 180,
                                      width: 150,
                                      color: Colors.pink));
                            }
                          },
                          itemCount: _groupCreateController.pics.length + 1,
                        )),
                    TextInputField(
                      label: "그룹이름",
                      hintText: "사람들에게 보여질 그룹이름을 입력해주세요",
                      controller: _groupCreateController.nameController,
                      keyboardType: TextInputType.text,
                    ),
                    LongTextBox(
                        controller: _groupCreateController.bioController,
                        label: "그룹소개"),
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Center(
                    child: _groupCreateController.isLoading.value == true
                        ? const CircularProgressIndicator()
                        : const Text(
                            "계속하기",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                onTap: () {
                  // call signUp func
                  _groupCreateController.createGroup();
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  void openDialog() {
    Get.dialog(
      SimpleDialog(
        title: Text("사진 업로드"),
        children: [
          TextButton(
              child: const Text("사진 촬영하기"),
              onPressed: () async {
                final _pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  maxHeight: 500,
                  maxWidth: 500,
                );

                if (_pickedFile != null) {
                  _groupCreateController.uploadPic(_pickedFile);
                } else {
                  print('No image selected.');
                }
              }),
          TextButton(
              child: const Text("갤러리에서 선택하기"),
              onPressed: () async {
                final _pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  maxHeight: 500,
                  maxWidth: 500,
                );

                if (_pickedFile != null) {
                  _groupCreateController.uploadPic(_pickedFile);
                } else {
                  print('No image selected.');
                }
              }),
        ],
      ),
    );
  }
}
