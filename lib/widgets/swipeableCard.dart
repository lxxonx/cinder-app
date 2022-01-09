import 'package:flutter/material.dart';

class SwipeableCard extends StatefulWidget {
  const SwipeableCard({Key? key}) : super(key: key);

  @override
  State<SwipeableCard> createState() => SwipeableCardState();
}

class SwipeableCardState extends State<SwipeableCard> {
  @override
  Widget build(BuildContext context) {
    return Text("hi");
  }

  Widget frontCard() {
    return Text("hi");
  }
}
