import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(includeIfNull: false)
  final String? username;
  @JsonKey(name: "actual_name", includeIfNull: false)
  final String? actualName;
  @JsonKey(includeIfNull: false)
  final String? bio;

  @JsonKey(includeIfNull: false)
  final String? uni;
  @JsonKey(includeIfNull: false)
  final String? dep;
  @JsonKey(includeIfNull: false)
  final String? gender;

  @JsonKey(includeIfNull: false)
  final String? avatar;
  @JsonKey(name: "birth_year", includeIfNull: false)
  final int? birthYear;

  @JsonKey(includeIfNull: false)
  final bool? isVerified;

  @JsonKey(includeIfNull: false)
  final String? status;
  List<Pic>? pics;

  User({
    this.status,
    this.username,
    this.avatar,
    this.isVerified,
    this.uni,
    this.bio,
    this.actualName,
    this.dep,
    this.gender,
    this.birthYear,
    List<Pic>? pics,
  }) : pics = pics ?? <Pic>[];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Pic {
  final String url;

  Pic(this.url);

  factory Pic.fromJson(Map<String, dynamic> json) => _$PicFromJson(json);

  Map<String, dynamic> toJson() => _$PicToJson(this);
}
