import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfo {
  final String username;
  final String bio;
  final String uni;
  final String dep; //
  final List profilePics;

  const ProfileInfo({
    required this.username,
    required this.bio,
    required this.uni,
    required this.dep,
    required this.profilePics,
  });

  static ProfileInfo fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ProfileInfo(
      username: snapshot["username"],
      bio: snapshot["bio"],
      uni: snapshot["uni"],
      dep: snapshot["dep"],
      profilePics: snapshot["profilePics"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "bio": bio,
        "uni": uni,
        "dep": dep,
        "profilePics": profilePics,
      };
}
