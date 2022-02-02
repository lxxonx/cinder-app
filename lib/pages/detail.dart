import 'package:cinder/models/profileInfo.dart';
import 'package:cinder/pages/settings.dart';
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
            child: Image(image: NetworkImage(pic), fit: BoxFit.fill),
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
        body: Column(children: [
          pics[_currentPic],
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("hi"),
            heroTag: Text(widget.profileInfo.profilePics[_currentPic]),
          ),
        ]));
  }
}
