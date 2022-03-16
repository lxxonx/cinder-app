import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  final String message;
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "users", includeIfNull: false)
  final Sender? sender;

  Message(
    this.createdAt,
    this.message, {
    this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Sender {
  @JsonKey(name: "actual_name")
  final String actualName;
  final String avatar;

  Sender(
    this.actualName,
    this.avatar,
  );

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
