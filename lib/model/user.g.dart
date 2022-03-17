// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      status: json['status'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      isVerified: json['isVerified'] as bool?,
      uni: json['uni'] as String?,
      bio: json['bio'] as String?,
      actualName: json['actual_name'] as String?,
      dep: json['dep'] as String?,
      gender: json['gender'] as String?,
      birthYear: json['birth_year'] as int?,
      pics: (json['pics'] as List<dynamic>?)
          ?.map((e) => Pic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('actual_name', instance.actualName);
  writeNotNull('bio', instance.bio);
  writeNotNull('uni', instance.uni);
  writeNotNull('dep', instance.dep);
  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('birth_year', instance.birthYear);
  writeNotNull('isVerified', instance.isVerified);
  writeNotNull('status', instance.status);
  val['pics'] = instance.pics;
  return val;
}

Pic _$PicFromJson(Map<String, dynamic> json) => Pic(
      json['url'] as String,
      json['uid'] as String,
    );

Map<String, dynamic> _$PicToJson(Pic instance) => <String, dynamic>{
      'url': instance.url,
      'uid': instance.uid,
    };
