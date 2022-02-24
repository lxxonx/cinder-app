import 'package:get/route_manager.dart';
import 'package:mocozi/app/views/home_page.dart';
import 'package:mocozi/resources/auth_methods.dart';
import 'package:mocozi/router/bottomNavigaion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isViewed;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // isViewed = prefs.getBool('onBoard');
  runApp(GetMaterialApp(
    home: HomePage(),
  ));
}
