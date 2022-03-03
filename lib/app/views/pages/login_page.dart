import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/views/pages/signup_page.dart';
import 'package:mocozi/pages/signup.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';
import 'package:mocozi/widgets/textInputField.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Form(
    //     key: _formKey,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 24.0),
    //       child: Center(
    //         child: SingleChildScrollView(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: <Widget>[
    //               LogoGraphicHeader(),
    //               SizedBox(height: 48.0),
    //               FormInputFieldWithIcon(
    //                 controller: authController.emailController,
    //                 iconPrefix: Icons.email,
    //                 labelText: 'auth.emailFormField'.tr,
    //                 validator: Validator().email,
    //                 keyboardType: TextInputType.emailAddress,
    //                 onChanged: (value) => null,
    //                 onSaved: (value) =>
    //                     authController.emailController.text = value!,
    //               ),
    //               FormVerticalSpace(),
    //               FormInputFieldWithIcon(
    //                 controller: authController.passwordController,
    //                 iconPrefix: Icons.lock,
    //                 labelText: 'auth.passwordFormField'.tr,
    //                 validator: Validator().password,
    //                 obscureText: true,
    //                 onChanged: (value) => null,
    //                 onSaved: (value) =>
    //                     authController.passwordController.text = value!,
    //                 maxLines: 1,
    //               ),
    //               FormVerticalSpace(),
    //               PrimaryButton(
    //                   labelText: 'auth.signInButton'.tr,
    //                   onPressed: () async {
    //                     if (_formKey.currentState!.validate()) {
    //                       authController.signInWithEmailAndPassword(context);
    //                     }
    //                   }),
    //               FormVerticalSpace(),
    //               LabelButton(
    //                 labelText: 'auth.resetPasswordLabelButton'.tr,
    //                 onPressed: () => Get.to(ResetPasswordUI()),
    //               ),
    //               LabelButton(
    //                 labelText: 'auth.signUpLabelButton'.tr,
    //                 onPressed: () => Get.to(SignUpUI()),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Logo(size: 34),
              const SizedBox(
                height: 24,
              ),
              TextInputField(
                hintText: "email",
                controller: authController.emailController,
                keyboardType: TextInputType.text,
              ),
              TextInputField(
                hintText: "password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: authController.passwordController,
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // login
                  authController.Login();
                },
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: primaryColor, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.android),
                      Text(
                        "Login with Google",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // login
                  authController.signInWithGoogle();
                },
              ),
              Flexible(child: Container(), flex: 2),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // move to forgot pw
                      },
                      child: const Text("Forgot Password?"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        // move to login
                        Get.off(SignupPage());
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
