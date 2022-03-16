// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      json['uid'] as String,
      DateTime.parse(json['updated_at'] as String),
      lastMessage: json['group_members'] == null
          ? null
          : Message.fromJson(json['group_members'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'uid': instance.uid,
      'updated_at': instance.updatedAt.toIso8601String(),
      'group_members': instance.lastMessage,
    };
