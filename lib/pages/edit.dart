import 'dart:typed_data';

import 'package:cinder/utils/pickImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({Key? key, this.state = "edit"}) : super(key: key);
  String state;
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  Uint8List? _profileImg;
  String? state;

  @override
  void initState() {
    super.initState();
    state = widget.state;
  }

  void selectImage() async {
    Uint8List img = await PickImage(ImageSource.gallery);
    setState(() {
      _profileImg = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            child: Text("done"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text("Edit", style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
