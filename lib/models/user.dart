import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String uni;
  final String dep; //
  final List friends;
  final List friendsReq;
  final List likeTo;
  final List likeFrom;
  final List profilePics;
  final List saves;

  const User(
      {required this.username,
      required this.uid,
      required this.email,
      required this.bio,
      required this.uni,
      required this.dep,
      required this.friends,
      required this.friendsReq,
      required this.likeTo,
      required this.likeFrom,
      required this.profilePics,
      required this.saves});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      bio: snapshot["bio"],
      uni: snapshot["uni"],
      dep: snapshot["dep"],
      friends: snapshot["friends"],
      friendsReq: snapshot["friendsReq"],
      likeTo: snapshot["likeTo"],
      likeFrom: snapshot["likeFrom"],
      profilePics: snapshot["profilePics"],
      saves: snapshot["saves"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "uni": uni,
        "dep": dep,
        "friends": friends,
        "friendsReq": friendsReq,
        "likeTo": likeTo,
        "likeFrom": likeFrom,
        "profilePics": profilePics,
        "saves": saves,
      };
}
