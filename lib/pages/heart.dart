import 'package:flutter/material.dart';

class HeartScreen extends StatefulWidget {
  HeartScreen({Key? key}) : super(key: key);

  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("heart"));
  }
}
