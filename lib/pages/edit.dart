import 'dart:typed_data';

import 'package:cinder/utils/colors.dart';
import 'package:cinder/utils/pickImage.dart';
import 'package:cinder/widgets/textOpacityButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key, this.state = "edit"}) : super(key: key);
  final String state;
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
    print(widget.state);
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
            child: Text("done", style: TextStyle(color: primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(state!, style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: TextOpacityButton(
                        onPressed: () {
                          setState(() {
                            state = "edit";
                          });
                        },
                        text: "edit",
                        color: state == "edit" ? primaryColor : Colors.black)),
                //Divider
                Container(
                  width: 1,
                  height: 12,
                  color: Colors.grey,
                ),
                Expanded(
                    flex: 1,
                    child: TextOpacityButton(
                        onPressed: () {
                          setState(() {
                            state = "preview";
                          });
                        },
                        text: "preview",
                        color:
                            state == "preview" ? primaryColor : Colors.black)),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ),
        ],
      ),
    );
  }
}
