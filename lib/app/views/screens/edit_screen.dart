import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/edit_controller.dart';
import 'package:mocozi/app/views/components/long_texbox.dart';
import 'package:mocozi/app/views/components/textbox.dart';
import 'package:mocozi/utils/colors.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);
  final EditController editController = Get.put(EditController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      // scrollDirection: Axis.horizontal,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  Container(height: 180, width: 150, color: Colors.pink),
              itemCount: 5,
            )),
        TextBox(
          label: "유저네임",
          text: editController.username.value,
        ),
        TextBox(
          label: "본명",
          text: editController.actualName.value,
        ),
        TextBox(
          label: "출생연도",
          text: editController.birthYear.value,
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
                  border:
                      Border.fromBorderSide(Divider.createBorderSide(context)),
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
                  border:
                      Border.fromBorderSide(Divider.createBorderSide(context)),
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
                  border:
                      Border.fromBorderSide(Divider.createBorderSide(context)),
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
          },
        ),
      ],
    );
  }
}
