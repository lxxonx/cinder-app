import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/app/controller/auth_controller.dart';
import 'package:mocozi/app/models/client_response.dart';
import 'package:mocozi/app/models/user.dart' as model;
import 'package:mocozi/app/services/remote_services.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<ClientResponse> register({
    username = String,
    actualName = String,
    birthYear = int,
    uni = String,
    dep = String,
    gender = String,
  }) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/register')
            : Uri.parse('http://192.168.9.174:8080/api/users/register'))
        : Uri.parse("some url");

    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    String uid = AuthController.to.firebaseUser.value!.uid;
    var response = await RemoteServices.client.post(url, body: {
      "uid": uid,
      "username": username,
      "actual_name": actualName,
      "birth_year": birthYear,
      "uni": uni,
      "dep": dep,
      "gender": gender,
    }, headers: {
      "Authorization": "Bearer $token",
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    ClientResponse cr = ClientResponse.fromJson(clientResponse);

    return cr;
  }

  static Future<model.User?> me() async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/current')
            : Uri.parse('http://192.168.9.174:8080/api/users/current'))
        : Uri.parse("some url");
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);
    try {
      var response = await RemoteServices.client.get(url, headers: {
        'Authorization': 'Bearer $uid',
      });
      var clientResponse = json.decode(utf8.decode(response.bodyBytes));
      ClientResponse cr = ClientResponse.fromJson(clientResponse);

      if (cr.ok) {
        var me = model.User.fromJson(cr.data!["me"]);
        return me;
      } else {
        Get.snackbar("개인정보 확인", "다음 내용을 채워서 회원가입을 완료해주세요! 🔧");
        Get.offAllNamed("/signUp");
        return null;
      }
    } catch (e) {
      print(e);
      Get.snackbar("오류발생", "오류가 발생했습니다 다시 로그인해주세요");

      FirebaseAuth.instance.signOut();
    }
  }

  static Future<bool> uploadStudentCard(XFile file) async {
    Uri url = RemoteServices.env == 'dev'
        ? (Platform.isAndroid
            ? Uri.parse('http://10.0.2.2:8080/api/users/sc')
            : Uri.parse('http://192.168.9.174:8080/api/users/sc'))
        : Uri.parse("some url");
    var _storage = FirebaseStorage.instance;
    var _auth = FirebaseAuth.instance;
    Reference ref = _storage.ref().child("s").child(_auth.currentUser!.uid);
    try {
      var _file = await file.readAsBytes();
      // putting in uint8list format -> Upload task like a future but not future
      UploadTask uploadTask = ref.putData(_file);

      TaskSnapshot snapshot = await uploadTask;
      String file_url = await snapshot.ref.getDownloadURL();

      String uid =
          await AuthController.to.firebaseUser.value!.getIdToken(false);

      var response = await RemoteServices.client.post(url, headers: {
        'Authorization': 'Bearer $uid',
      }, body: {
        "pic_url": file_url,
      });

      var clientResponse = json.decode(utf8.decode(response.bodyBytes));
      ClientResponse cr = ClientResponse.fromJson(clientResponse);

      if (cr.ok) {
        Get.snackbar("학생증 전송에 성공했습니다", "본인 확인까지 최대 하루가 소요됩니다");
        Get.offNamed("/");
      }
      return cr.ok;
    } catch (e) {
      print(e);
      Get.snackbar("err", "upload fail");
      return false;
    }
  }
}
