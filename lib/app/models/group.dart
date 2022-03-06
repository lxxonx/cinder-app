import 'package:flutter/material.dart';
import 'package:mocozi/app/models/user.dart';

class Group {
  late String uid;
  late String groupname;
  late String createdAt;
  late String bio;
  late List<User> members;
  late List<ImageProvider?> pics;
  Group({
    uid,
    groupName,
    createTime,
    bio,
    members,
  });

  Group.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    groupname = json['groupname'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    var mem = json['edges']['members'];
    List<dynamic> ds = mem.map((model) => User.fromJson(model)).toList();
    members = List<User>.from(ds);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['groupname'] = groupname;
    data['createdAt'] = createdAt;
    data['bio'] = bio;
    data['members'] = members;
    return data;
  }
}
