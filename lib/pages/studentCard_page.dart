import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MOCOZI/controllers/cam_controller.dart';
import 'package:MOCOZI/utils/colors.dart';
import 'package:MOCOZI/utils/logo.dart';

class StudentCardPage extends StatelessWidget {
  CamController? camController = Get.put(CamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Logo(
                    size: 32,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("학생증 등록 ",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Image.asset("images/id-card.png"),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "학교와 이름이 잘 보이도록 학생증 전면을 촬영해 주세요. \n잘 나오지 않은 사진은 회원가입이 거절될 수 있습니다\n가입승인시까지 최대 하루가 소요될 수 있습니다",
                            textAlign: TextAlign.center,
                            style: TextStyle(height: 1.8, fontSize: 14))),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                      child: camController!.isLoading.value == true
                          ? const CircularProgressIndicator()
                          : const Text(
                              "촬영하기",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  onTap: () {
                    // take pic
                    camController!.uploadStudentCard();
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
