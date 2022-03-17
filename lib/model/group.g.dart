// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      json['groupname'] as String,
      bio: json['bio'] as String?,
      pics: (json['pics'] as List<dynamic>?)
          ?.map((e) => Pic.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['group_members'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupToJson(Group instance) {
  final val = <String, dynamic>{
    'groupname': instance.groupname,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bio', instance.bio);
  val['pics'] = instance.pics;
  val['group_members'] = instance.members;
  return val;
}

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      User.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'users': instance.users,
    };
