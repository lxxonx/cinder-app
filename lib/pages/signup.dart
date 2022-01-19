import 'package:cinder/pages/login.dart';
import 'package:cinder/resources/auth_methods.dart';
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
  final TextEditingController _uniController = TextEditingController();
  final TextEditingController _depController = TextEditingController();
  String _uni = "";

  void signUp() async {
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      uni: _uniController.text,
      dep: _depController.text,
    );
    print(res);
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
              const Text(
                "cinder",
                style: TextStyle(
                  color: Colors.pink,
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
                  Navigator.of(context).restorablePush(_modalBuilder);
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
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.pink,
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

  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    _SignUpScreenState? stateObject =
        context.findAncestorStateOfType<_SignUpScreenState>();

    List<String> universities = [
      "Select University",
      "Action One",
      "Action Two",
    ];

    List<Widget> uniOptionBuilder() {
      List<Widget> res = [];
      for (var uni in universities) {
        res.add(Text(uni));
      }
      return res;
    }

    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 180,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                print(selected);
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
}
