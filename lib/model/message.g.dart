// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      DateTime.parse(json['created_at'] as String),
      json['message'] as String,
      sender: json['users'] == null
          ? null
          : Sender.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{
    'message': instance.message,
    'created_at': instance.createdAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('users', instance.sender);
  return val;
}

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      json['actual_name'] as String,
      json['avatar'] as String,
    );

Map<String, dynamic> _$SenderToJson(Sender instance) => <String, dynamic>{
      'actual_name': instance.actualName,
      'avatar': instance.avatar,
    };
