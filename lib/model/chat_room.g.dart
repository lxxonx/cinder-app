// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      json['uid'] as String,
      DateTime.parse(json['updated_at'] as String),
      lastMessage: (json['chat_messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['chat_room_participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'uid': instance.uid,
      'updated_at': instance.updatedAt.toIso8601String(),
      'chat_messages': instance.lastMessage,
      'chat_room_participants': instance.participants,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      ParticipantUser.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'users': instance.user,
    };

ParticipantUser _$ParticipantUserFromJson(Map<String, dynamic> json) =>
    ParticipantUser(
      json['avatar'] as String,
    );

Map<String, dynamic> _$ParticipantUserToJson(ParticipantUser instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
    };
