import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocozi/app/controller/friend_controller.dart';
import 'package:mocozi/app/controller/message_controller.dart';
import 'package:mocozi/app/controller/phoneVerify_controller.dart';
import 'package:mocozi/app/models/user.dart' as model;
import 'package:mocozi/app/services/auth_services.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/app/views/pages/signup_page.dart';
import 'package:mocozi/app/views/pages/studentCard_page.dart';
import 'package:mocozi/app/views/pages/welcome_page.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var hasPhoneNumber = false.obs;
  // var isSubmitting = false.obs;
  static AuthController to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<model.User?> curUser = Rxn<model.User>();

  // TextEditingController phoneController = TextEditingController();

  // TextEditingController controller1 = TextEditingController();
  // TextEditingController controller2 = TextEditingController();
  // TextEditingController controller3 = TextEditingController();
  // TextEditingController controller4 = TextEditingController();
  // TextEditingController controller5 = TextEditingController();
  // TextEditingController controller6 = TextEditingController();
  // TextEditingController currController = TextEditingController();

  // FocusNode controller1fn = FocusNode();
  // FocusNode controller2fn = FocusNode();
  // FocusNode controller3fn = FocusNode();
  // FocusNode controller4fn = FocusNode();
  // FocusNode controller5fn = FocusNode();
  // FocusNode controller6fn = FocusNode();
  // String phoneNumber = "";

  // String _verificationId = "";

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    // currController.dispose();
    // controller1.dispose();
    // controller2.dispose();
    // controller3.dispose();
    // controller4.dispose();
    // controller5.dispose();
    // controller6.dispose();
    super.onClose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<UserCredential> signUpWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  handleAuthChanged(User? _firebaseUser) async {
    //get user data from backend

    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(WelcomePage());
    } else {
      var me = await AuthServices.me();
      curUser.value = me;
      // MessageController.to.connectSokcetIO();
      switch (me!.status) {
        case "phone_number_verified":
          return Get.offAll(SignupPage());
        case "registered":
          // 회원가입했으니 학생증 인증 안됐을 때

          return Get.offAll(StudentCardPage());
        case "pic_sent":
          // 학생증 인증 끝나고 처음 입장
          FriendController.to.getFriendsList();
          FriendController.to.getRequestsList();
          FriendController.to.getMyGroup();
          return Get.offAll(HomePage());
        case "first_time":
          // 학생증 인증 끝나고 처음 입장
          FriendController.to.getFriendsList();
          FriendController.to.getRequestsList();
          FriendController.to.getMyGroup();
          return Get.offAll(HomePage());
        case "normal":
          // 학생증 인증 끝났을 때
          FriendController.to.getFriendsList();
          FriendController.to.getRequestsList();
          FriendController.to.getMyGroup();
          return Get.offAll(HomePage());
      }
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();
}
