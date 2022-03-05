import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/services/auth_services.dart';
import 'package:mocozi/app/services/remote_services.dart';
import 'package:mocozi/app/views/pages/login_page.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/app/views/pages/signup_page.dart';
import 'package:mocozi/app/views/pages/verifyPhone_page.dart';
import 'package:mocozi/app/views/pages/welcome_page.dart';

class WelcomeController extends GetxController {
  // var isLoading = true.obs;
  // final currentIndex = 0.obs;

  // List<Widget> pages = [
  //   SignupPage(),
  //   LoginPage(),
  //   VerifyCodePage(),
  //   VerifyCodePage(),
  // ];

  // Widget get currentPage => pages[currentIndex.value];

  // void changePage(int _index) {
  //   currentIndex.value = _index;
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
