import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocozi/app/model/group.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Group>> fetchGroups() async {
    var response =
        await client.get(Uri.parse('https://localhost:8080/api/groups'));
    print(response);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Iterable jsonResponse = json.decode(response.body);
      print(jsonResponse);
      List<Group> groupList =
          jsonResponse.map((model) => Group.fromJson(model)).toList();

      return groupList;
    } else {
      print('error');
      return [];
    }
  }
}
