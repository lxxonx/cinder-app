import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/controllers/auth_controller.dart';

class PhoneVerifyController extends GetxController {
  var isLoading = false.obs;
  var hasPhoneNumber = false.obs;
  var hasCode = false.obs;
  // var isSubmitting = false.obs;

  static PhoneVerifyController to = Get.find();

  late TextEditingController phoneController;

  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;
  late TextEditingController controller5;
  late TextEditingController controller6;
  late TextEditingController currController;

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
    phoneController.dispose();
    currController.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    phoneController = TextEditingController();
    currController = TextEditingController();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
    controller6 = TextEditingController();
    super.onInit();
  }

  void signUpWithPhoneNumber() async {
    phoneNumber = phoneController.text.trim();
    String phoneNumberWithCountryCode = "+82" + phoneNumber.substring(1);

    print(phoneNumberWithCountryCode);
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumberWithCountryCode,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await FirebaseAuth.instance.signInWithCredential(credential);
          return;
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.code);
          // print(authException.message);
          if (authException.message!.contains("invalid-verification-code")) {
            Get.snackbar("인증코드를 확인해주세요", "입력한 인증코드가 올바르지 않습니다.");
          }
        },
        // autoRetrievedSmsCodeForTesting: "321321",
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
