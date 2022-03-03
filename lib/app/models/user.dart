import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // final String uid;
  // final String email;
  final String username;
  final String? bio;
  final String uni;
  final String dep; //
  // final List friends;
  // final List friendsReq;
  // final List likeTo;
  // final List likeFrom;
  // final List saves;

  const User({
    required this.username,
    // required this.uid,
    // required this.email,
    required this.bio,
    required this.uni,
    required this.dep,
    // required this.friends,
    // required this.friendsReq,
    // required this.likeTo,
    // required this.likeFrom,
    // required this.saves,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"],
      // uid: json["uid"],
      // email: json["email"],
      bio: json["bio"],
      uni: json["uni"],
      dep: json["dep"],
      // friends: json["friends"],
      // friendsReq: json["friendsReq"],
      // likeTo: json["likeTo"],
      // likeFrom: json["likeFrom"],
      // saves: json["saves"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        // "uid": uid,
        // "email": email,
        "bio": bio,
        "uni": uni,
        "dep": dep,
        // "friends": friends,
        // "friendsReq": friendsReq,
        // "likeTo": likeTo,
        // "likeFrom": likeFrom,
        // "saves": saves,
      };
}
