import 'package:cinder/pages/login.dart';
import 'package:cinder/resources/auth_methods.dart';
import 'package:cinder/utils/colors.dart';
import 'package:cinder/widgets/TextInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String _uni = "Select University";
  String _dep = "Select Department";
  void signUp() async {
    if (_dep == "Select Department") {
      // toast
      return;
    }
    if (_uni == "Select University") {
      // toast
      return;
    }
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      uni: _uni,
      dep: _dep,
    );
    print(res);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

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
                "cinder",
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextInputField(
                hintText: "username",
                controller: _usernameController,
                keyboardType: TextInputType.text,
              ),
              TextInputField(
                hintText: "password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
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
                    child: Text(_uni),
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
                    child: Text(_dep),
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
                  signUp();
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
                    setState(() {
                      _uni = universities[selected];
                    });
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
                    setState(() {
                      _dep = departments[selected];
                    });
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
