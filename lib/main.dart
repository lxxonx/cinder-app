import 'package:get/route_manager.dart';
import 'package:mocozi/app/routes/routes.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/resources/auth_methods.dart';
import 'package:mocozi/router/bottomNavigaion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isViewed;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // isViewed = prefs.getBool('onBoard');
  runApp(GetMaterialApp(
      initialRoute: '/',
      getPages: routes,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: secondaryColor,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: secondaryColor,
            elevation: 0,
            iconTheme: IconThemeData(color: primaryColor)),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      )));
}
