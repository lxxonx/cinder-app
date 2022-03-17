import 'package:flutter/material.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/components/profile_pic.dart';
import 'package:mocozi/components/profile_pic_plus.dart';
import 'package:mocozi/components/text_input_field.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/controllers/signUp_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  SignUpController signUpController = SignUpController();
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("프로필 사진"),
                    ),
                    SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var len = AuthController
                                        .to.curUser.value?.pics?.length !=
                                    null
                                ? AuthController.to.curUser.value!.pics!.length
                                : 0;
                            if (index < len) {
                              return ProfilePic(
                                pic: AuthController
                                    .to.curUser.value!.pics![index].url,
                                onPressed: () => signUpController.deletePic(
                                    AuthController
                                        .to.curUser.value!.pics![index].uid),
                              );
                              // Container(
                              //   height: 180,
                              //   width: 150,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //       image: NetworkImage(
                              //         AuthController
                              //             .to.curUser.value!.pics![index].url,
                              //       ),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // );
                            } else {
                              return ProfilePicPlus(onPressed: openDialog);
                            }
                          },
                          itemCount: AuthController
                                      .to.curUser.value?.pics?.length !=
                                  null
                              ? AuthController.to.curUser.value!.pics!.length +
                                  1
                              : 1,
                        )),
                    TextInputField(
                      label: "유저이름",
                      hintText: "친구들에게 보여질 이름을 입력해주세요",
                      controller: signUpController.usernameController,
                      keyboardType: TextInputType.text,
                    ),
                    TextInputField(
                      label: "본명",
                      hintText: "본명을 입력해주세요",
                      controller: signUpController.actualNameController,
                      keyboardType: TextInputType.text,
                    ),
                    TextInputField(
                      label: "출생연도",
                      hintText: "태여난 연도를 입력해주세요 예) 2001",
                      controller: signUpController.birthYearController,
                      keyboardType: TextInputType.number,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpController.selectGender(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text("성별")),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.fromBorderSide(
                                  Divider.createBorderSide(context)),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(signUpController.gender.value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpController.selectUni(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text("소속대학교")),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.fromBorderSide(
                                  Divider.createBorderSide(context)),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(signUpController.uni.value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpController.selectDep(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text("소속단과대")),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.fromBorderSide(
                                  Divider.createBorderSide(context)),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(signUpController.dep.value),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    child: signUpController.isLoading.value == true
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
                  signUpController.signUp();
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
                  signUpController.uploadPic(_pickedFile);
                } else {
                  print('No image selected.');
                }
              }),
          TextButton(
              child: const Text("갤러리에서 선택하기"),
              onPressed: () async {
                final _pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 500,
                  maxWidth: 500,
                );

                if (_pickedFile != null) {
                  signUpController.uploadPic(_pickedFile);
                } else {
                  print('No image selected.');
                }
              }),
        ],
      ),
    );
  }
}
