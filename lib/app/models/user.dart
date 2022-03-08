class User {
  // final String uid;
  // final String email;          username: me?.username,
  final String username;
  final String actualName;
  final String? bio;
  final String uni;
  final String dep; //
  final String gender;
  final String birthYear;
  final bool? isVerified;
  final String status;
  // final List friends;
  // final List friendsReq;
  // final List likeTo;
  // final List likeFrom;
  // final List saves;

  const User({
    required this.username,
    required this.actualName,
    // required this.uid,
    // required this.email,
    this.bio,
    required this.uni,
    required this.dep,
    required this.gender,
    required this.birthYear,
    required this.isVerified,
    required this.status,
    // required this.friends,
    // required this.friendsReq,
    // required this.likeTo,
    // required this.likeFrom,
    // required this.saves,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"],
      actualName: json["actual_name"],
      // uid: json["uid"],
      // email: json["email"],
      bio: json["bio"],
      uni: json["uni"],
      dep: json["dep"],
      birthYear: json["birth_year"],
      gender: json["gender"],
      isVerified: json["is_verified"],
      status: json["status"],
      // createdAt: json["created_at"],
      // friends: json["friends"],
      // friendsReq: json["friendsReq"],
      // likeTo: json["likeTo"],
      // likeFrom: json["likeFrom"],
      // saves: json["saves"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data["actual_name"] = actualName;
    data["bio"] = bio;
    data["uni"] = uni;
    data["dep"] = dep;
    data["birth_year"] = birthYear;
    data["gender"] = gender;
    data["is_verified"] = isVerified;
    data["status"] = status;
    return data;
  }
}
