import 'package:json_annotation/json_annotation.dart';
part 'http_response.g.dart';

@JsonSerializable()
class HttpResponse {
  final bool ok;
  @JsonKey(includeIfNull: false)
  final String? message;
  @JsonKey(includeIfNull: false)
  final String? field;

  @JsonKey(includeIfNull: false)
  final Map<String, dynamic>? data;

  HttpResponse(
    this.ok, {
    this.message,
    this.field,
    this.data,
  });

  factory HttpResponse.fromJson(Map<String, dynamic> json) =>
      _$HttpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HttpResponseToJson(this);
}
