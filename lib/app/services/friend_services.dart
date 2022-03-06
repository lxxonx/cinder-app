import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/models/friend.dart';
import 'package:mocozi/app/models/user.dart';
import 'package:mocozi/app/services/remote_services.dart';

class FriendServices {
  static Future<List<User>?> fetchFriends() async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/friends')
            : Uri.parse('http://localhost:8080/api/friends'))
        : Uri.parse("some url");

    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(utf8.decode(response.bodyBytes));
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var fr = cr.data!["friends"];
      List<dynamic> ds = fr.map((model) => User.fromJson(model)).toList();
      List<User> friendsList = List<User>.from(ds);
      return friendsList;
    } else {
      // show toast
      return null;
    }
  }

  static Future<String?> searchFriends(String friendName) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/friends/search')
            : Uri.parse('http://localhost:8080/api/friends/search'))
        : Uri.parse("some url");

    print(friendName);
    var response = await RemoteServices.client.post(url, body: {
      "friendName": friendName,
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);

    if (cr.ok) {
      var friend = cr.data!["friend"];
      print(friend);
      return friend;
    } else {
      return null;
    }
  }

  static Future<bool> sendRequest(String friendName) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/friends/req')
            : Uri.parse('http://localhost:8080/api/friends/req'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.post(url, body: {
      "friendName": friendName,
    }, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    if (!cr.ok) {
      Get.snackbar("오류", cr.message.toString());
    }
    return cr.ok;
  }

  static Future<List<Friend>?> getRequest() async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/friends/req')
            : Uri.parse('http://localhost:8080/api/friends/req'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);

    if (cr.ok) {
      var fr = cr.data!["requests"];
      List<dynamic> ds = fr.map((model) => Friend.fromJson(model)).toList();
      List<Friend> requests = List<Friend>.from(ds);
      return requests;
    } else {
      Get.snackbar("오류", "친구 신청 목록을 불러올 수 없습니다",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.pink,
          duration: Duration(seconds: 2));
      return null;
    }
  }
}
