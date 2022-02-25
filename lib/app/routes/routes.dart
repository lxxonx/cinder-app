import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/app/views/pages/nav_page.dart';
import 'package:mocozi/pages/explore.dart';
import 'package:mocozi/pages/profile.dart';

var routes = [
  GetPage(
    name: '/',
    page: () => NavPage(),
  ),
  GetPage(
    name: '/cart',
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
];
