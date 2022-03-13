// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResponse _$HttpResponseFromJson(Map<String, dynamic> json) => HttpResponse(
      json['ok'] as bool,
      message: json['message'] as String?,
      field: json['field'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$HttpResponseToJson(HttpResponse instance) {
  final val = <String, dynamic>{
    'ok': instance.ok,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('field', instance.field);
  writeNotNull('data', instance.data);
  return val;
}
