import 'package:json_annotation/json_annotation.dart';
import 'package:mocozi/model/message.dart';
part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  final String uid;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  @JsonKey(name: "chat_messages", includeIfNull: false)
  List<Message> lastMessage;

  @JsonKey(name: "chat_room_participants", includeIfNull: false)
  List<Participant> participants;

  ChatRoom(
    this.uid,
    this.updatedAt, {
    List<Message>? lastMessage,
    List<Participant>? participants,
  })  : lastMessage =
            lastMessage ?? [Message(DateTime.now(), "", sender: null)],
        participants = participants ?? [];

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

@JsonSerializable()
class Participant {
  @JsonKey(name: "users", includeIfNull: false)
  final ParticipantUser user;

  Participant(this.user);

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}

@JsonSerializable()
class ParticipantUser {
  final String avatar;

  ParticipantUser(this.avatar);

  factory ParticipantUser.fromJson(Map<String, dynamic> json) =>
      _$ParticipantUserFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantUserToJson(this);
}
