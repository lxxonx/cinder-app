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
            : Uri.parse('http://192.168.9.174:8080/api/groups'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(response.body.toString());
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var groups = cr.data!["groups"];
      List<dynamic> ds = groups.map((model) => Group.fromJson(model)).toList();
      List<Group> groupList = List<Group>.from(ds);
      return groupList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<Group> joinGroup(List<String> friends, String groupname) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups/join')
            : Uri.parse('http://localhost:8080/api/groups/join'))
        : Uri.parse("some url");

    var response = await RemoteServices.client.post(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(response.body.toString());
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var group = Group.fromJson(cr.data!["group"]);
      return group;
    } else {
      throw Exception('Failed to join group');
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
    var clientResponse = json.decode(response.body.toString());
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
  //   static Future<Group> joinGroup(List<String> friends, String groupname) async {
  //   Uri url = RemoteServices.env == 'dev'
  //       ? (Platform.isAndroid
  //           ? Uri.parse('http://10.0.2.2:8080/api/groups/join')
  //           : Uri.parse('http://localhost:8080/api/groups/join'))
  //       : Uri.parse("some url");

  //   var response = await RemoteServices.client.post(url);

  //   var clientResponse = json.decode(utf8.decode(response.bodyBytes));
  //   ClientResponse cr = ClientResponse.fromJson(clientResponse);
  //   if (cr.ok) {
  //     var group = Group.fromJson(cr.data!["group"]);
  //     return group;
  //   } else {
  //     throw Exception('Failed to join group');
  //   }
  // }
}
