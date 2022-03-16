import 'package:flutter/material.dart';
import 'package:mocozi/components/friend_item.dart';
import 'package:mocozi/controllers/friend_controller.dart';
import 'package:mocozi/controllers/groupCreate_controller.dart';
import 'package:mocozi/pages/groupCreate_page.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

class GroupCreateScreen extends StatefulWidget {
  @override
  _GroupCreateScreenState createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  final FriendController _friendController = FriendController.to;
  final GroupCreateController _groupCreateController =
      Get.put(GroupCreateController());
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Column(
      children: [
        TextField(
          controller: _groupCreateController.nameController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            hintText: "친구의 이름을 입력해주세요",
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: inputBorder,
          ),
          keyboardAppearance: Brightness.light,
          keyboardType: TextInputType.text,
        ),
        Obx(
          () => Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white),
                margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
                padding: EdgeInsets.all(4),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FriendItem(
                      friend: _friendController.friendsList[index],
                    ),
                    Checkbox(
                        value: _checked,
                        onChanged: (value) {
                          setState(() {
                            _checked = value!;
                          });
                          if (value!) {
                            _groupCreateController.checked
                                .add(_friendController.friendsList[index]);
                          } else {}
                        }),
                  ],
                ),
              ),
              itemCount: _friendController.friendsList.length,
            ),
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: const Center(
              child: Text(
                "그룹만들기",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () {
            // _groupCreateController.createGroup();
            Get.to(GroupCreatePage());
          },
        ),
      ],
    );
  }
}
