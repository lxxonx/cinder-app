import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/controller/friend_controller.dart';
import 'package:mocozi/app/views/components/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/widgets/textOpacityButton.dart';

class FriendScreen extends StatelessWidget {
  final FriendController _friendController = FriendController.to;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderSide: BorderSide.none);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.fromBorderSide(Divider.createBorderSide(context)),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 5,
                child: TextField(
                  controller: _friendController.searchController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                    hintText: "친구를 검색해보세요",
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                  keyboardAppearance: Brightness.light,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _friendController.searchFriend();
                  },
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (_friendController.searchResult.value == null) {
            return Center(
                // child: Text('No friends'),
                );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("검색결과"),
                    ),
                    TextOpacityButton(
                        onPressed: () => _friendController.resetResult(),
                        text: '초기화',
                        fontSize: 12,
                        color: Colors.grey),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
                  padding: EdgeInsets.all(4),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FriendItem(friend: _friendController.searchResult.value!),
                      TextOpacityButton(
                        onPressed: () => _friendController.sendRequest(
                            _friendController.searchResult.value!.username),
                        color: Colors.green,
                        text: '친구 신청',
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
        Obx(() => _friendController.requestsList.isEmpty
            ? Center()
            : Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text(
                  "친구 요청",
                  textAlign: TextAlign.start,
                ))),
        Obx(() {
          if (_friendController.requestsList.isEmpty) {
            return Center(
                // child: Text('No friends'),
                );
          }
          return Expanded(
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
                      friend: _friendController.requestsList[index],
                    ),
                    GestureDetector(
                      onTap: () {
                        _friendController.acceptFriend(
                            _friendController.requestsList[index].username);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Text(
                          '수락',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: _friendController.requestsList.length,
            ),
          );
        }),
        Obx(() => _friendController.friendsList.isEmpty
            ? Center(child: Text('친구가 없습니다.'))
            : Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "친구 목록",
                  textAlign: TextAlign.start,
                ))),
        Obx(() {
          if (_friendController.friendsList.isEmpty) {
            return const Center(
                // child: Text('No friends'),
                );
          }
          return Expanded(
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
                    GestureDetector(
                      onTap: () {
                        _friendController.acceptFriend(
                            _friendController.friendsList[index].username);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: const Text(
                          '그룹 만들기',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: _friendController.friendsList.length,
            ),
          );
        }),
      ],
    );
  }
}
