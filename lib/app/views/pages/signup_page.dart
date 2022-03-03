import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/pages/login.dart';
import 'package:mocozi/resources/auth_methods.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/widgets/TextInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatelessWidget {
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
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
              Text(
                "mocozi",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextInputField(
                hintText: "email",
                controller: authController.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextInputField(
                hintText: "username",
                controller: authController.nameController,
                keyboardType: TextInputType.text,
              ),
              TextInputField(
                hintText: "password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: authController.passwordController,
              ),
              GestureDetector(
                onTap: () {
                  _selectUni(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 0.04)),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(authController.uni),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDep(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 0.04)),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(authController.dep),
                  ),
                ),
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
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // sign up,
                  authController.signUp();
                },
              ),
              Flexible(child: Container(), flex: 2),
              Row(
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
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectUni(context) {
    List<String> universities = [
      "Select University",
      "Action One",
      "Action Two",
      "Action Three",
      "Action Four",
    ];

    List<Widget> uniOptionBuilder() {
      List<Widget> res = [];
      for (var uni in universities) {
        res.add(Text(uni));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
            cancelButton: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("selected"),
            ),
            actions: [
              Container(
                height: 180,
                child: CupertinoPicker(
                  itemExtent: 28,
                  onSelectedItemChanged: (selected) {
                    authController.uni = universities[selected];
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

  void _selectDep(context) {
    List<String> departments = [
      "Select University",
      "Action One",
      "Action Two",
      "Action Three",
      "Action Four",
    ];

    List<Widget> depOptionBuilder() {
      List<Widget> res = [];
      for (var dep in departments) {
        res.add(Text(dep));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
            cancelButton: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("selected"),
            ),
            actions: [
              Container(
                height: 180,
                child: CupertinoPicker(
                  itemExtent: 28,
                  onSelectedItemChanged: (selected) {
                    authController.dep = departments[selected];
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
}
