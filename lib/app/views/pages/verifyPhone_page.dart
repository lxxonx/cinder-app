import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/controller/phoneVerify_controller.dart';
import 'package:mocozi/utils/colors.dart';

class VerifyPhonePage extends StatelessWidget {
  VerifyPhonePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PhoneVerifyController _phoneVerifyController =
        Get.put(PhoneVerifyController(), tag: "phoneVerify");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              width: double.infinity,
              child: const Text(
                '내 전화번호: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '전화번호를 입력해주세요',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
                onChanged: (value) {
                  value.isEmpty
                      ? _phoneVerifyController.hasPhoneNumber.value = false
                      : _phoneVerifyController.hasPhoneNumber.value = true;
                },
                keyboardType: TextInputType.number,
                controller: _phoneVerifyController.phoneController,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Text(
                "인증 코드를 문자 메시지로 보내드립니다. 문자 메시지 및 데이터 요금이 적용될 수 있습니다.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          ]),
          Obx(() => InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: _phoneVerifyController.hasPhoneNumber.value == false ||
                          _phoneVerifyController.isLoading.value == true
                      ? Colors.black12
                      : primaryColor,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Center(
                  child: _phoneVerifyController.isLoading.value
                      ? CircularProgressIndicator()
                      : Text(
                          "계속하기",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              onTap: () {
                if (_phoneVerifyController.hasPhoneNumber.value == true) {
                  return _phoneVerifyController.signUpWithPhoneNumber();
                } else {
                  return;
                }
              }
              // call phone verify func

              ))
        ],
      ),
    );
  }
}
