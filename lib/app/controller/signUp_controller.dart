import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/const/departments.dart';
import 'package:mocozi/app/const/universities.dart';
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/services/auth_services.dart';
import 'package:mocozi/app/views/pages/studentCard_page.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  var isLoading = false.obs;
  // var isSubmitting = false.obs;

  var uni = "대학교를 선택하세요".obs;
  var dep = "단과대를 선택하세요".obs;
  var gender = "성별을 선택하세요".obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController birthYearController = TextEditingController();
  TextEditingController actualNameController = TextEditingController();

  void selectUni(context) {
    List<String> unis = [
      "대학교를 선택하세요",
    ];
    unis.addAll(universities);

    List<Widget> uniOptionBuilder() {
      List<Widget> res = [];
      for (var u in unis) {
        res.add(Text(u));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                uni.value = unis[selected];
              },
              useMagnifier: true,
              backgroundColor: Colors.white,
              magnification: 1.5,
              children: uniOptionBuilder(),
            ),
          ),
        ]);
      },
    );
  }

  void selectDep(context) {
    List<String> deps = ["단과대를 선택하세요"];

    deps.addAll(departments);
    List<Widget> depOptionBuilder() {
      List<Widget> res = [];
      for (var dp in deps) {
        res.add(Text(dp));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 300,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                dep.value = deps[selected];
              },
              useMagnifier: true,
              backgroundColor: Colors.white,
              magnification: 1.5,
              children: depOptionBuilder(),
            ),
          ),
        ]);
      },
    );
  }

  void selectGender(context) {
    List<String> genders = [
      "성별을 선택하세요",
      "여성",
      "남성",
      "기타",
    ];

    List<Widget> genderOptionBuilder() {
      List<Widget> res = [];
      for (var g in genders) {
        res.add(Text(g));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 180,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                gender.value = genders[selected];
              },
              useMagnifier: true,
              backgroundColor: Colors.white,
              magnification: 1.5,
              children: genderOptionBuilder(),
            ),
          ),
        ]);
      },
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    phoneController.dispose();

    birthYearController.dispose();
    actualNameController.dispose();

    super.onClose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void signUp() async {
    String actualName = actualNameController.text;
    String username = usernameController.text;
    String birthYear = birthYearController.text;
    if (username == "" ||
        actualName == "" ||
        birthYear == "" ||
        dep.value == "단과대를 선택하세요" ||
        uni.value == "대학교를 선택하세요" ||
        gender.value == "성별을 선택하세요") {
      Get.snackbar('Error', '모든 내용을 채워주세요',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
      return;
    }
    try {
      isLoading.value = true;
      ClientResponse cr = await AuthServices.register(
          username: username,
          actualName: actualName,
          birthYear: birthYear,
          uni: uni.value,
          dep: dep.value,
          gender: gender.value);
      if (cr.ok) {
        // 학생증 등록 페이지 이동
        Get.offAll(StudentCardPage());
      } else {
        Get.snackbar('Error', cr.message.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 10,
            margin: EdgeInsets.all(10));
        isLoading.value = false;
      }
    } catch (err) {
      if (err.toString().contains("weak-password")) {
        // TODO
        // add toast
      }
      print(err.toString());
      isLoading.value = false;
    }
  }
}
