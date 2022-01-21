import 'package:cinder/resources/auth_methods.dart';
import 'package:cinder/widgets/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void login() async {
    print(_emailController.text);
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    print(res);
    if (res == "success") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('onBoard', true);
      Navigator.pushNamed(context, "/");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.text,
              ),
              TextInputField(
                hintText: "password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
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
                  login();
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
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: const Text(
                      "Sign Up",
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
}
