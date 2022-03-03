import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/app/views/pages/splash_page.dart';
import 'package:mocozi/pages/explore.dart';
import 'package:mocozi/pages/profile.dart';

var routes = [
  GetPage(
    name: '/',
    page: () => SplashPage(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
  ),
  GetPage(
    name: '/explore',
    page: () => ExploreScreen(),
  ),
  GetPage(
    name: '/profile',
    page: () => ProfileScreen(name: "lxxlxx"),
    transition: Transition.leftToRight,
    curve: Curves.ease,
    preventDuplicates: true,
    popGesture: false,
  ),
  GetPage(
    name: '/login',
    page: () => ProfileScreen(name: "lxxlxx"),
    transition: Transition.leftToRight,
    curve: Curves.ease,
    preventDuplicates: true,
    popGesture: false,
  ),
];
