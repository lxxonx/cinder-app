import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/components/labeled_text_box.dart';
import 'package:mocozi/components/long_text_box.dart';
import 'package:mocozi/components/profile_pic.dart';
import 'package:mocozi/components/profile_pic_plus.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/controllers/edit_controller.dart';
import 'package:mocozi/utils/colors.dart';

class EditPage extends StatelessWidget {
  EditPage({
    Key? key,
  }) : super(key: key);
  final EditController editController = Get.put(EditController());
  final AuthController _auth = AuthController.to;
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
        // scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var len = _auth.curUser.value?.pics?.length != null
                        ? _auth.curUser.value!.pics!.length
                        : 0;
                    if (index < len) {
                      return ProfilePic(
                          onPressed: () {
                            editController.deletePic(
                                _auth.curUser.value!.pics![index].uid);
                          },
                          pic: _auth.curUser.value!.pics![index].url);
                    } else {
                      return ProfilePicPlus(onPressed: openDialog);
                    }
                  },
                  itemCount: _auth.curUser.value?.pics?.length != null
                      ? _auth.curUser.value!.pics!.length + 1
                      : 1,
                ));
          }),
          LabeledTextBox(
            label: "유저이름",
            text: _auth.curUser.value!.username,
          ),
          LabeledTextBox(
            label: "본명",
            text: _auth.curUser.value!.actualName,
          ),
          LabeledTextBox(
            label: "출생연도",
            text: _auth.curUser.value!.birthYear,
          ),
          GestureDetector(
            onTap: () {
              editController.selectGender(context);
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
                  child: Obx(() {
                    return Center(
                      child: Text(editController.gender.value),
                    );
                  }),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              editController.selectUni(context);
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
                  child: Obx(() {
                    return Center(
                      child: Text(editController.uni.value),
                    );
                  }),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              editController.selectDep(context);
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
                  child: Obx(() {
                    return Center(
                      child: Text(editController.dep.value),
                    );
                  }),
                ),
              ],
            ),
          ),
          LongTextBox(controller: editController.bioController, label: "자기소개"),
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
                child: editController.isLoading.value == true
                    ? const CircularProgressIndicator()
                    : const Text(
                        "저장하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            onTap: () {
              editController.save();
            },
          ),
        ],
      ),
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
                  editController.uploadPic(_pickedFile);
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
                  editController.uploadPic(_pickedFile);
                } else {
                  print('No image selected.');
                }
              }),
        ],
      ),
    );
  }
}
