import 'package:app/pages/settings.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: Column(children: [
          Hero(
            child: Image(
                image: AssetImage("images/beauty1.jpeg"), fit: BoxFit.fill),
            tag: "profile_pics",
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("hi"),
          ),
        ]));
  }
}
