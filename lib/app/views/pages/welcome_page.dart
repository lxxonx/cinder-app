import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/controller/welcome_controller.dart';
import 'package:mocozi/app/views/pages/signup_page.dart';
import 'package:mocozi/pages/signup.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';
import 'package:mocozi/widgets/textInputField.dart';

class WelcomePage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final WelcomeController welcomeController = Get.put(WelcomeController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Logo(size: 34, color: Colors.white),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: const Center(
                    child: Text(
                      "계정 만들기",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // signup
                  Get.toNamed("/verifyPhone");
                },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "로그인",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // login
                  Get.off(SignupPage());
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    // move to login
                    Get.off(SignupPage());
                  },
                  child: const Text(
                    "로그인에 문제가 있나요?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
