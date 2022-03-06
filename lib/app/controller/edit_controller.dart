import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/const/departments.dart';
import 'package:mocozi/app/const/universities.dart';
import 'package:mocozi/app/controller/auth_controller.dart';

class EditController extends GetxController {
  static EditController get to => Get.find();
  Widget get currentPage => pages[currentIndex.value];

  var isLoading = false.obs;
  var hasMore = false.obs;
  var tap = "edit".obs;
  final currentIndex = 0.obs;
  late List<Widget> pages;

  TextEditingController searchController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }
  // var isSubmitting = false.obs;

  var uni = "대학교를 선택하세요".obs;
  var dep = "단과대를 선택하세요".obs;
  var gender = "성별을 선택하세요".obs;
  var username = "".obs;
  var actualName = "".obs;
  var birthYear = "".obs;
  var imageList = <String>[].obs;

  void selectUni(context) {
    List<String> unis = [];
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
    List<String> deps = [];

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
    bioController.dispose();

    super.onClose();
  }

  void changeTap(String _newTap) {
    switch (_newTap) {
      case "edit":
        tap.value = _newTap;
        break;
      case "preview":
        tap.value = _newTap;
        break;
      default:
        tap.value = "edit";
    }
  }

  void getUser() {
    var user = AuthController.to.curUser.value;
    username.value = user!.username;
    actualName.value = user.actualName;
    bioController.text = user.bio!;
    birthYear.value = user.birthYear.toString();
    uni.value = user.uni;
    dep.value = user.dep;
    gender.value = user.gender;
  }
}
