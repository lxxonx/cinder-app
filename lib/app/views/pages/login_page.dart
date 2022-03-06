import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/views/pages/signup_page.dart';
import 'package:mocozi/pages/signup.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';
import 'package:mocozi/widgets/textInputField.dart';

class LoginPage extends StatelessWidget {
  // final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          // child: Column(
          //   children: [
          //     Flexible(
          //       flex: 2,
          //       child: Container(),
          //     ),
          //     Logo(size: 34),
          //     const SizedBox(
          //       height: 24,
          //     ),
          //     TextInputField(
          //       hintText: "username",
          //       controller: authController.phoneController,
          //       keyboardType: TextInputType.text,
          //     ),
          //     InkWell(
          //       child: Container(
          //         margin: EdgeInsets.symmetric(vertical: 2),
          //         width: double.infinity,
          //         height: 50,
          //         decoration: BoxDecoration(
          //             color: primaryColor,
          //             borderRadius: BorderRadius.circular(4.0)),
          //         child: const Center(
          //           child: Text(
          //             "Login",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //       onTap: () {
          //         // login
          //         // authController.signUpWithPhoneNumber();
          //       },
          //     ),
          //     InkWell(
          //       child: Container(
          //         margin: EdgeInsets.symmetric(vertical: 2),
          //         width: double.infinity,
          //         height: 50,
          //         decoration: BoxDecoration(
          //           color: Colors.white10,
          //           borderRadius: BorderRadius.circular(4.0),
          //           border: Border.all(color: primaryColor, width: 1),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(Icons.android),
          //             Text(
          //               "계정 만들기",
          //               style: TextStyle(
          //                 color: primaryColor,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       onTap: () {
          //         // login
          //         authController.signUpWithGoogle();
          //       },
          //     ),
          //     Flexible(child: Container(), flex: 2),
          //     Container(
          //       padding: EdgeInsets.symmetric(vertical: 20),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               // move to forgot pw
          //             },
          //             child: const Text("Forgot Password?"),
          //           ),
          //           const SizedBox(
          //             width: 12,
          //           ),
          //           GestureDetector(
          //             onTap: () {
          //               // move to login
          //               Get.off(SignupPage());
          //             },
          //             child: const Text(
          //               "Sign Up",
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
