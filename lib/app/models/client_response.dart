class ClientResponse {
  late bool ok;
  late String? message;
  late String? field;
  late Map<String, dynamic>? data;
  ClientResponse({
    ok,
    message,
    field,
    data,
  });

  ClientResponse.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    message = json['message'];
    field = json['field'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['ok'] = ok;
    json['message'] = message;
    json['field'] = field;
    json['data'] = data;
    return json;
  }
}
