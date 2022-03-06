import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/models/user.dart';
import 'package:mocozi/app/services/remote_services.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<ClientResponse> register({
    username = String,
    actualName = String,
    birthYear = String,
    uni = String,
    dep = String,
    gender = String,
  }) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/signup')
            : Uri.parse('http://192.168.9.174:8080/api/users/signup'))
        : Uri.parse("some url");
    String uid = AuthController.to.firebaseUser.value!.uid;
    var response = await RemoteServices.client.post(url, body: {
      'uid': uid,
      'username': username,
      'actualName': actualName,
      'birthYear': birthYear,
      'uni': uni,
      'dep': dep,
      'gender': gender,
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);
    return cr;
  }

  static Future<User?> me() async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/current')
            : Uri.parse('http://192.168.9.174:8080/api/users/current'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response = await RemoteServices.client.get(url, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);

    if (cr.ok) {
      var me = User.fromJson(cr.data!["me"]);
      return me;
    } else {
      Get.snackbar("다시 돌아오셨군요 ㅠㅠ", "다음 내용을 채워서 회원가입을 완료해주세요! 🔧");
      Get.offAllNamed("/signUp");
      return null;
    }
  }

  static Future<bool> uploadStudentCard(XFile file) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/sc')
            : Uri.parse('http://192.168.9.174:8080/api/users/sc'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);

    var request = new http.MultipartRequest("POST", url);
    request.headers.addAll({
      'Authorization': 'Bearer $uid',
      'Content-Type': 'multipart/form-data',
    });
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      await file.readAsBytes(),
      filename: file.name,
    ));
    var response = await request.send().then((res) {
      return res.stream.bytesToString();
    });
    var clientResponse = json.decode(response.toString());
    ClientResponse cr = ClientResponse.fromJson(clientResponse);

    return cr.ok;
  }
}
