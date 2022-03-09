import 'package:flutter/material.dart';
import 'package:mocozi/app/models/user.dart';

class Group {
  late String groupname;
  // late String createdAt;
  late String bio;
  late List<User> members;
  late List<dynamic> pics;
  Group({
    groupName,
    createTime,
    bio,
    members,
  });

  Group.fromJson(Map<String, dynamic> json) {
    groupname = json["groupname"];
    bio = json['bio'];
    // createdAt = json['createdAt'];
    var mem = json['group_members'];
    List<dynamic> ds = mem.map((model) => User.fromJson(model)).toList();
    members = List<User>.from(ds);
    pics = json['pics'].map((pic) {
      return pic['url'];
    }).toList();
    // pics = json['pics']['url'] as List<String>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupname'] = groupname;
    // data['createdAt'] = createdAt;
    data['bio'] = bio;
    data['members'] = members;
    return data;
  }
}
