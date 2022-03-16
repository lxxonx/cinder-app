import 'package:json_annotation/json_annotation.dart';
import 'package:MOCOZI/model/message.dart';
part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  final String uid;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  @JsonKey(name: "group_members", includeIfNull: false)
  Message lastMessage;

  ChatRoom(
    this.uid,
    this.updatedAt, {
    Message? lastMessage,
  }) : lastMessage = lastMessage ?? Message(DateTime.now(), "", sender: null);

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
