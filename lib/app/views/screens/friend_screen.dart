import 'package:mocozi/app/controller/friend_controller.dart';
import 'package:mocozi/app/views/components/swipeable_card.dart';
import 'package:flutter/material.dart';
import 'package:mocozi/widgets/chatListItem.dart';
import 'package:get/get.dart';
import 'package:mocozi/widgets/textInputField.dart';

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
              border: Border.fromBorderSide(Divider.createBorderSide(context))),
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
              // Obx(() {
              //   return SizedBox(
              //     height: 40,
              //     width: 40,
              //     child: IconButton(
              //       icon: Icon(
              //           _friendController.searchController.text.isNotEmpty &&
              //                   _friendController.searchResult.value ==
              //                       "검색 결과가 없습니다"
              //               ? Icons.close
              //               : Icons.search),
              //       onPressed: () {
              //         if (_friendController.searchController.text.isNotEmpty &&
              //             _friendController.searchResult.value ==
              //                 "검색 결과가 없습니다") {
              //           _friendController.resetResult();
              //         } else {
              //           _friendController.searchFriend();
              //         }
              //       },
              //     ),
              //   );
              // }),
            ],
          ),
        ),
        Obx(() {
          if (_friendController.searchLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_friendController.searchController.text.isEmpty) {
              return GestureDetector(
                child: Container(
                  height: 30,
                ),
              );
            } else {
              return Card(
                elevation: 2,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_friendController.searchResult.value.isNotEmpty
                          ? _friendController.searchResult.value
                          : "검색 결과가 없습니다"),
                      Container(
                        child: _friendController.searchResult.value ==
                                    "검색 결과가 없습니다" ||
                                _friendController.searchResult.value.isEmpty
                            ? Text("")
                            : IconButton(
                                onPressed: () {
                                  _friendController.sendRequest();
                                },
                                icon: Icon(Icons.add)),
                      )
                    ],
                  ),
                ),
              );
            }
          }
        }),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => ChatListItem(
                // friend: _friendController.friendsList[index],
                ),
            itemCount: _friendController.requestsList.length,
          ),
        ),
        // Obx(() {
        //   if (_friendController.friendsList.isEmpty) {
        //     return Center(
        //       child: Text('No friends'),
        //     );
        //   }
        //   return ListView.builder(
        //     itemBuilder: (context, index) => ChatListItem(
        //         // friend: _friendController.friendsList[index],
        //         ),
        //     itemCount: _friendController.friendsList.length,
        //   );
        // }),
      ],
    );
  }
}
