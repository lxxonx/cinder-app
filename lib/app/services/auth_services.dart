import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mocozi/app/models/user.dart';
import 'package:mocozi/resources/auth_methods.dart';

class AuthServices {
  static var client = http.Client();

  static var env = dotenv.env['ENV'] ?? 'dev';

  static Future<User> register({
    uid: String,
    email = String,
    password = String,
    username = String,
    uni = String,
    dep = String,
  }) async {
    Uri url = env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/signup')
            : Uri.parse('http://192.168.9.174:8080/api/users/signup'))
        : Uri.parse("some url");
    var response = await client.post(url, body: {
      'uid': uid,
      'email': email,
      'password': password,
      'username': username,
      'uni': uni,
      'dep': dep,
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(response.body.toString());
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var me = User.fromJson(cr.data["me"]);
      return me;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<Group> joinGroup(List<String> friends, String groupname) async {
    Uri url = env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/groups/join')
            : Uri.parse('http://localhost:8080/api/groups/join'))
        : Uri.parse("some url");

    var response = await client.post(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(response.body.toString());
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var group = Group.fromJson(cr.data["group"]);
      return group;
    } else {
      throw Exception('Failed to join group');
    }
  }

  static Future<List<User>> fetchFriends(
      List<String> friends, String groupname) async {
    Uri url = env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/friends')
            : Uri.parse('http://localhost:8080/api/friends'))
        : Uri.parse("some url");

    var response = await client.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(response.body.toString());
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var fr = cr.data["friends"];
      List<dynamic> ds = fr.map((model) => User.fromJson(model)).toList();
      List<User> friendsList = List<User>.from(ds);
      return friendsList;
    } else {
      throw Exception('Failed to join group');
    }
  }
}
