import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mocozi/components/opacity_button.dart';
import 'package:mocozi/controllers/phoneVerify_controller.dart';
import 'package:mocozi/utils/colors.dart';

class VerifyCodePage extends StatelessWidget {
  static const double dist = 3.0;

  VerifyCodePage({Key? key}) : super(key: key);
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    final PhoneVerifyController _phoneVerifyController =
        Get.find(tag: "phoneVerify");
    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            enabled: true,
            controller: _phoneVerifyController.controller1,
            autofocus: true,
            focusNode: _phoneVerifyController.controller1fn,
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller1fn,
                    _phoneVerifyController.controller2fn);
              }
            },
            textAlign: TextAlign.center,
            // style: TextStyle(
            //     fontSize: appDimens.text24, color: AppColors.greyText),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller2fn,
                    _phoneVerifyController.controller3fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller2fn,
                    _phoneVerifyController.controller1fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: _phoneVerifyController.controller2,
            focusNode: _phoneVerifyController.controller2fn,
            enabled: true,
            textAlign: TextAlign.center,
            // style: TextStyle(
            //     fontSize: appDimens.text24, color: AppColors.greyText),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller3fn,
                    _phoneVerifyController.controller4fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller3fn,
                    _phoneVerifyController.controller2fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: _phoneVerifyController.controller3,
            focusNode: _phoneVerifyController.controller3fn,
            textAlign: TextAlign.center,
            enabled: true,
            // style: TextStyle(
            //     fontSize: appDimens.text24, color: AppColors.greyText),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller4fn,
                    _phoneVerifyController.controller5fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller4fn,
                    _phoneVerifyController.controller3fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: _phoneVerifyController.controller4,
            focusNode: _phoneVerifyController.controller4fn,
            enabled: true,
            // style: TextStyle(
            //     fontSize: appDimens.text24, color: AppColors.greyText),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller5fn,
                    _phoneVerifyController.controller6fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller5fn,
                    _phoneVerifyController.controller4fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: _phoneVerifyController.controller5,
            focusNode: _phoneVerifyController.controller5fn,
            textAlign: TextAlign.center,
            enabled: true,
            // style: TextStyle(
            //     fontSize: appDimens.text24, color: AppColors.greyText),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length == 0) {
                _fieldFocusChange(context, _phoneVerifyController.controller6fn,
                    _phoneVerifyController.controller5fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: _phoneVerifyController.controller6,
            focusNode: _phoneVerifyController.controller6fn,
            enabled: true,
            // style: TextStyle(
            //     fontSize: appDimens.text24, color: AppColors.greyText),
          ),
        ),
      ),
    ];
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
                '인증 코드: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(_phoneVerifyController.phoneNumber,
                        style: TextStyle(fontSize: 16)),
                  ),
                  OpacityButton(
                      onPressed: () {
                        // 코드 재전송
                      },
                      text: "재전송",
                      color: Colors.black)
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            //   child: TextField(
            //     autofocus: true,
            //     decoration: const InputDecoration(
            //       hintText: '전화번호를 입력해주세요',
            //       hintStyle: TextStyle(
            //         fontSize: 16,
            //         color: Colors.grey,
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: primaryColor),
            //       ),
            //       enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: primaryColor),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       value.isEmpty
            //           ? _authController.hasInput.value = false
            //           : _authController.hasInput.value = true;
            //     },
            //     keyboardType: TextInputType.number,
            //     controller: _authController.phoneController,
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              child: GridView.count(
                crossAxisCount: 6,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1,
                scrollDirection: Axis.vertical,
                children: List<Container>.generate(
                  6,
                  (int index) => Container(
                    child: widgetList[index],
                  ),
                ),
              ),
            ),
          ]),
          Obx(() => InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color:
                      (_phoneVerifyController.controller1.text.trim() == "" ||
                              _phoneVerifyController.controller2.text.trim() ==
                                  "" ||
                              _phoneVerifyController.controller3.text.trim() ==
                                  "" ||
                              _phoneVerifyController.controller4.text.trim() ==
                                  "" ||
                              _phoneVerifyController.controller5.text
                                      .trim() ==
                                  "" ||
                              _phoneVerifyController.controller6.text.trim() ==
                                  "")
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
                return _phoneVerifyController.verifyCode();
              }
              // call phone verify func

              ))
        ],
      ),
    );
  }
}
