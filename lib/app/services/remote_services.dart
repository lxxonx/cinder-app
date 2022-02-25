import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/models/group.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Group>> fetchGroups() async {
    var response =
        await client.get(Uri.parse('http://localhost:8080/api/groups'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var clientResponse = json.decode(response.body.toString());
      ClientResponse cr = ClientResponse.fromJson(clientResponse);
      var groups = cr.data["groups"];
      List<dynamic> ds = groups.map((model) => Group.fromJson(model)).toList();
      List<Group> groupList = List<Group>.from(ds);
      return groupList;
    } else {
      print('error');
      return [];
    }
  }
}
