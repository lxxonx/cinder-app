import 'package:mocozi/models/profileInfo.dart';
import 'package:mocozi/pages/settings.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {Key? key, required this.profileInfo, required this.currentPicIndex})
      : super(key: key);
  final ProfileInfo profileInfo;
  final int currentPicIndex;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    pics = widget.profileInfo.profilePics
        .map(
          (pic) => Hero(
            child: Container(
                height: 500,
                child: Image(image: NetworkImage(pic), fit: BoxFit.cover)),
            tag: pic,
          ),
        )
        .toList();
    _currentPic = widget.currentPicIndex;
  }

  late List<Hero> pics;
  late int _currentPic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(children: [
        pics[_currentPic],
        FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("hi"),
          heroTag: Text(widget.profileInfo.profilePics[_currentPic]),
        ),
        Container(height: 200, color: Colors.green),
        Container(height: 200, color: Colors.red),
        Container(height: 200, color: Colors.pink),
        Container(height: 200, color: Colors.purple),
      ]),
    );
  }
}
