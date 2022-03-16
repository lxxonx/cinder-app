import 'package:json_annotation/json_annotation.dart';
import 'package:MOCOZI/model/user.dart';
part 'group.g.dart';

@JsonSerializable()
class Group {
  final String groupname;
  @JsonKey(includeIfNull: false)
  final String? bio;

  @JsonKey(includeIfNull: false)
  List<Pic> pics;
  @JsonKey(name: "group_members", includeIfNull: false)
  List<Member> members;

  Group(
    this.groupname, {
    this.bio,
    List<Pic>? pics,
    List<Member>? members,
  })  : pics = pics ?? <Pic>[],
        members = members ?? <Member>[];

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}

@JsonSerializable()
class Member {
  final User users;

  Member(this.users);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
