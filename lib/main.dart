import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MOCOZI/controllers/auth_controller.dart';
import 'package:MOCOZI/controllers/friend_controller.dart';
import 'package:MOCOZI/routes/routes.dart';
import 'package:MOCOZI/utils/colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  Get.put<AuthController>(AuthController());
  Get.put<FriendController>(FriendController());
  // Get.put<MessageController>(MessageController());
  // Get.put<CamController>(CamController());

  runApp(GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
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
        appBarTheme: const AppBarTheme(
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
