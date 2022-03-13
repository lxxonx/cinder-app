import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mocozi/pages/edit_page.dart';
import 'package:mocozi/pages/home_page.dart';
import 'package:mocozi/pages/settings_page.dart';
import 'package:mocozi/pages/splash_page.dart';
import 'package:mocozi/pages/verifyCode_page.dart';
import 'package:mocozi/pages/verifyPhone_page.dart';

var routes = [
  GetPage(
    name: '/',
    page: () => SplashPage(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
  ),
  // GetPage(
  //   name: '/explore',
  //   page: () => ExploreScreen(),
  // ),
  // GetPage(
  //   name: '/signUp',
  //   page: () => SignupPage(),
  // ),
  // GetPage(
  //   name: '/login',
  //   page: () => LoginPage(),
  //   transition: Transition.fadeIn,
  //   curve: Curves.ease,
  //   preventDuplicates: true,
  //   popGesture: true,
  // ),
  GetPage(
    name: '/verifyPhone',
    page: () => VerifyPhonePage(),
    transition: Transition.downToUp,
    curve: Curves.ease,
    preventDuplicates: true,
    popGesture: false,
  ),
  GetPage(
    name: '/verifyCode',
    page: () => VerifyCodePage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.ease,
    preventDuplicates: true,
    popGesture: false,
  ),
  GetPage(
    name: '/edit',
    page: () => EditPage(),
    transition: Transition.downToUp,
    curve: Curves.ease,
    preventDuplicates: true,
    popGesture: false,
  ),
  GetPage(
    name: '/settings',
    page: () => SettingsPage(),
    transition: Transition.downToUp,
    curve: Curves.ease,
    preventDuplicates: true,
    popGesture: false,
  ),
];
