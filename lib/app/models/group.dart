import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  late String uid;
  late String groupName;
  late List<dynamic> pics;
  late String createTime;
  late String bio;
  Group({
    uid,
    groupName,
    pics,
    createTime,
    bio,
  });

  Group.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    groupName = json['groupName'];
    pics = json['pics'];
    bio = json['bio'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['groupName'] = groupName;
    data['pics'] = pics;
    data['createTime'] = createTime;
    data['bio'] = bio;
    return data;
  }
}
