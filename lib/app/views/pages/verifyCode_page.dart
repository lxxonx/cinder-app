import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/widgets/textOpacityButton.dart';

class VerifyCodePage extends StatelessWidget {
  final AuthController _authController = AuthController.to;
  static const double dist = 3.0;

  VerifyCodePage({Key? key}) : super(key: key);
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _authController.controller1,
            autofocus: true,
            focusNode: _authController.controller1fn,
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, _authController.controller1fn,
                    _authController.controller2fn);
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
                _fieldFocusChange(context, _authController.controller2fn,
                    _authController.controller3fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _authController.controller2fn,
                    _authController.controller1fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: _authController.controller2,
            focusNode: _authController.controller2fn,
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
                _fieldFocusChange(context, _authController.controller3fn,
                    _authController.controller4fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _authController.controller3fn,
                    _authController.controller2fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: _authController.controller3,
            focusNode: _authController.controller3fn,
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
                _fieldFocusChange(context, _authController.controller4fn,
                    _authController.controller5fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _authController.controller4fn,
                    _authController.controller3fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: _authController.controller4,
            focusNode: _authController.controller4fn,
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
                _fieldFocusChange(context, _authController.controller5fn,
                    _authController.controller6fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, _authController.controller5fn,
                    _authController.controller4fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: _authController.controller5,
            focusNode: _authController.controller5fn,
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
                _fieldFocusChange(context, _authController.controller6fn,
                    _authController.controller5fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: _authController.controller6,
            focusNode: _authController.controller6fn,
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
                    child: Text(_authController.phoneNumber,
                        style: TextStyle(fontSize: 16)),
                  ),
                  TextOpacityButton(
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
                  color: _authController.hasPhoneNumber.value == false
                      ? Colors.black12
                      : primaryColor,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Center(
                  child: _authController.isLoading.value
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
                return _authController.verifyCode();
              }
              // call phone verify func

              ))
        ],
      ),
    );
  }
}
