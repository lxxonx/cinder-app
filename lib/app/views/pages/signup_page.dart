import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:mocozi/app/components/formInputField.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/controller/welcome_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';
import 'package:mocozi/widgets/textInputField.dart';

class SignupPage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextInputField(
                      label: "유저네임",
                      hintText: "친구들에게 보여질 이름을 입력해주세요",
                      controller: authController.usernameController,
                      keyboardType: TextInputType.text,
                    ),
                    TextInputField(
                      label: "본명",
                      hintText: "본명을 입력해주세요",
                      controller: authController.actualNameController,
                      keyboardType: TextInputType.text,
                    ),
                    TextInputField(
                      label: "출생연도",
                      hintText: "태여난 연도를 입력해주세요 예) 2001",
                      controller: authController.birthYearContoller,
                      keyboardType: TextInputType.number,
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          authController.selectGender(context);
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
                                child: Text(authController.gender.value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          authController.selectUni(context);
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
                                child: Text(authController.uni.value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          authController.selectDep(context);
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
                                child: Text(authController.dep.value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
