import 'dart:convert';
import 'dart:io';

import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/services/remote_services.dart';

class GroupServices {
  static Future<List<Group>> fetchGroups() async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups')
            : Uri.parse('http://localhost:8080/api/groups'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    if (cr.ok) {
      var groups = cr.data!["groups"];
      if (groups == null || groups.length == 0) {
        return [];
      }

      List<dynamic> ds = groups.map((model) => Group.fromJson(model)).toList();
      List<Group> groupList = List<Group>.from(ds);
      return groupList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<Group?> createGroup({
    groupname: String,
    friendNames: List<String>,
    bio: String,
    pic_url: String,
  }) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups/create')
            : Uri.parse('http://localhost:8080/api/groups/create'))
        : Uri.parse("some url");

    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });
    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    if (cr.ok) {
      var gd = cr.data!["group"];
      if (gd == null) {
        return null;
      }
      Group group = Group.fromJson(gd);

      return group;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<List<Group>> getMyGroup() async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups/my')
            : Uri.parse('http://192.168.9.174:8080/api/groups/my'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });
    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    if (cr.ok) {
      var groups = cr.data!["groups"];
      if (groups.length == 0) {
        return [];
      }
      List<dynamic> ds = groups.map((model) => Group.fromJson(model)).toList();
      List<Group> myGroup = List<Group>.from(ds);

      return myGroup;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<bool> likeGroup(String groupname) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups/like')
            : Uri.parse('http://localhost:8080/api/groups/like'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.post(url, body: {
      'group_name': groupname,
    }, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    if (cr.ok) {
    } else {}
    return cr.ok;
  }

  static Future<bool> dislikeGroup(String groupname) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups/dislike')
            : Uri.parse('http://localhost:8080/api/groups/dislike'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.post(url, body: {
      'group_name': groupname,
    }, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    if (cr.ok) {
    } else {}
    return cr.ok;
  }
}
