import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerifyController extends GetxController {
  var isLoading = false.obs;
  var hasPhoneNumber = false.obs;
  var hasCode = false.obs;
  // var isSubmitting = false.obs;

  TextEditingController phoneController = TextEditingController();

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController currController = TextEditingController();

  FocusNode controller1fn = FocusNode();
  FocusNode controller2fn = FocusNode();
  FocusNode controller3fn = FocusNode();
  FocusNode controller4fn = FocusNode();
  FocusNode controller5fn = FocusNode();
  FocusNode controller6fn = FocusNode();

  String phoneNumber = "";

  String _verificationId = "";

  @override
  void onClose() {
    currController.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    super.onClose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void signUpWithPhoneNumber() async {
    phoneNumber = phoneController.text.trim();
    String phoneNumberWithCountryCode = "+82" + phoneNumber.substring(1);

    isLoading.value = true;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumberWithCountryCode,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Home()),
              //     (route) => false);
              print("loggedin");
            }
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.code);
          print(authException.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          print("code sent");
          _verificationId = verificationId;
          isLoading.value = false;
          Get.toNamed("/verifyCode");
          hasPhoneNumber.value = false;
          currController = controller1;
          print(_verificationId);
        },
        timeout: const Duration(minutes: 2),
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  void verifyCode() async {
    isLoading.value = true;
    if (controller1.text.trim() == "" ||
        controller2.text.trim() == "" ||
        controller3.text.trim() == "" ||
        controller4.text.trim() == "" ||
        controller5.text.trim() == "" ||
        controller6.text.trim() == "") {
      Get.snackbar('Error', '올바른 인증 코드를 입력해주세요',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
      // Utility.showToast(msg: "Please enter valid verification code.");
    } else {
      var otp = (controller1.text.trim() +
          controller2.text.trim() +
          controller3.text.trim() +
          controller4.text.trim() +
          controller5.text.trim() +
          controller6.text.trim());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: otp);

        print(credential.providerId);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            Get.offNamed("/signup");
          } else {
            // Utility.showToast(msg: "Sign in failed");
            Get.snackbar('Error', '로그인에 실패했습니다',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                borderRadius: 10,
                margin: EdgeInsets.all(10));
          }
        });
      } catch (e) {
        print(e);

        // Utility.showToast(msg: e.toString());
        // _showProgressDialog(false);
      }
    }

    isLoading.value = false;
  }
}
