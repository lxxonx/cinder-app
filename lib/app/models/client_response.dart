import 'package:cloud_firestore/cloud_firestore.dart';

class ClientResponse {
  late bool ok;
  late String message;
  late Map<String, dynamic> data;
  ClientResponse({
    ok,
    message,
    data,
  });

  ClientResponse.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['ok'] = ok;
    json['message'] = message;
    json['data'] = data;
    return json;
  }
}
