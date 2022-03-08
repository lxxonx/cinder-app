class Friend {
  // final String uid;
  // final String email;
  final String username;
  final String actualName;
  final String? bio;
  final String uni;
  final String dep; //
  final String gender;
  final String? avatar;
  final int birthYear;
  // final List friends;
  // final List friendsReq;
  // final List likeTo;
  // final List likeFrom;
  // final List saves;

  const Friend({
    required this.username,
    required this.actualName,
    // required this.uid,
    // required this.email,
    this.bio = "",
    required this.uni,
    required this.dep,
    required this.gender,
    this.avatar = "",
    required this.birthYear,
    // required this.friends,
    // required this.friendsReq,
    // required this.likeTo,
    // required this.likeFrom,
    // required this.saves,
  });

  static Friend fromJson(Map<String, dynamic> json) {
    return Friend(
      username: json["username"],
      actualName: json["actual_name"],
      // uid: json["uid"],
      // email: json["email"],
      bio: json["bio"],
      uni: json["uni"],
      dep: json["dep"],
      avatar: json["avatar"],
      birthYear: json["birth_year"],
      gender: json["gender"],
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
    data["avatar"] = avatar;
    data["birth_year"] = birthYear;
    data["gender"] = gender;
    return data;
  }
}
