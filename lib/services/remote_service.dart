import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/model/chat_room.dart';
import 'package:mocozi/model/group.dart';
import 'package:mocozi/model/http_response.dart';
import 'package:mocozi/model/user.dart';

class Apis {
  static final baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8080/api'
      : 'http://192.168.9.174:8080/api';
  // static const baseUrl = "https://mocozi.blackmonkeys.biz/api";

  // user apis
  static var registerUserApi = Uri.parse('$baseUrl/users/register');
  static var currentUserApi = Uri.parse('$baseUrl/users/current');
  static var updateUserApi = Uri.parse('$baseUrl/users/update');
  static var uploadPicApi = Uri.parse('$baseUrl/users/pic');
  static var deletePicApi = Uri.parse('$baseUrl/users/pic');
  static var uploadStudentCardApi = Uri.parse('$baseUrl/users/sc');

  // friend apis
  static var fetchFriendApi = Uri.parse('$baseUrl/friends/');
  static var searchFriendApi = Uri.parse('$baseUrl/friends/search');
  static var searchFriendBase = '$baseUrl/friends/search';
  static var requestFriendApi = Uri.parse('$baseUrl/friends/request');
  static var acceptFriendApi = Uri.parse('$baseUrl/friends/accept');

  // group apis
  static var fetchGroupApi = Uri.parse('$baseUrl/groups/');
  static var fetchMyGroupApi = Uri.parse('$baseUrl/groups/my');
  static var createGroupApi = Uri.parse('$baseUrl/groups/create');
  static var likeGroupApi = Uri.parse('$baseUrl/groups/like');
  static var uploadGroupPicApi = Uri.parse('$baseUrl/groups/pic');
  static var dislikeGroupApi = Uri.parse('$baseUrl/groups/dislike');

  // chat apis
  static var fetchChatListApi = Uri.parse('$baseUrl/chats/list');
}

class RemoteServices {
  static var client = http.Client();

// user services

  static Future<HttpResponse> registerUser({
    username = String,
    actualName = String,
    birthYear = int,
    uni = String,
    dep = String,
    gender = String,
  }) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.post(Apis.registerUserApi, body: {
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
    HttpResponse cr = HttpResponse.fromJson(clientResponse);

    return cr;
  }

  static Future<bool> updateProfile({
    uni = String,
    dep = String,
    gender = String,
    bio = String,
  }) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response = await RemoteServices.client.put(Apis.updateUserApi, body: {
      "uni": uni,
      "dep": dep,
      "gender": gender,
      "bio": bio,
    }, headers: {
      "Authorization": "Bearer $token",
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));

    HttpResponse cr = HttpResponse.fromJson(clientResponse);

    if (cr.ok) {
      Get.snackbar("성공", "프로필 업데이트에 성공했습니다 ");
      Get.back();
      AuthController.to.curUser.value = User.fromJson(cr.data!['me']);
    }
    return cr.ok;
  }

  static Future<User?> currentUser() async {
    try {
      String token =
          await AuthController.to.firebaseUser.value!.getIdToken(false);
      final response = await client.get(Apis.currentUserApi, headers: {
        "Authorization": "Bearer ${token}",
      });
      var clientResponse = json.decode(utf8.decode(response.bodyBytes));
      var res = HttpResponse.fromJson(clientResponse);
      if (res.ok) {
        return User.fromJson(res.data!['me']);
      } else {
        Get.snackbar("개인정보 확인", "다음 내용을 채워서 회원가입을 완료해주세요! 🔧");
        Get.offAllNamed("/signUp");
        return null;
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load current user');
    }
  }

  static Future<Pic?> uploadPic(XFile file) async {
    try {
      var _file = file.path;
      // putting in uint8list format -> Upload task like a future but not future

      String token =
          await AuthController.to.firebaseUser.value!.getIdToken(false);
      var request = http.MultipartRequest("POST", Apis.uploadPicApi);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath("photo", _file));
      var j = await request
          .send()
          .then((res) => res.stream.bytesToString())
          .then((value) => json.decode(value));
      var res = HttpResponse.fromJson(j);

      if (res.ok) {
        return Pic.fromJson(res.data!["pic"]);
      } else {
        Get.snackbar("사진 업로드 실패", "다시 시도해주세요! 🔧");
        return null;
      }
    } catch (e) {
      print(e);
      Get.snackbar("err", "upload fail");
      return null;
    }
  }

  static Future<bool> deletePic(String picUid) async {
    try {
      String token =
          await AuthController.to.firebaseUser.value!.getIdToken(false);
      final response = await client.delete(Apis.deletePicApi, headers: {
        "Authorization": "Bearer ${token}",
      }, body: {
        "pic_id": picUid,
      });
      var clientResponse = json.decode(utf8.decode(response.bodyBytes));

      print(clientResponse);
      var res = HttpResponse.fromJson(clientResponse);
      if (res.ok) {
        return res.ok;
      } else {
        Get.snackbar("오류발생", res.message.toString());
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load current user');
    }
  }

  static Future<bool> uploadStudentCard(XFile file) async {
    try {
      var _file = await file.path;
      // putting in uint8list format -> Upload task like a future but not future

      String token =
          await AuthController.to.firebaseUser.value!.getIdToken(false);
      var request = http.MultipartRequest("POST", Apis.uploadStudentCardApi);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath("photo", _file));
      var j = await request
          .send()
          .then((res) => res.stream.bytesToString())
          .then((value) => json.decode(value));
      var res = HttpResponse.fromJson(j);
      if (res.ok) {
        Get.snackbar("성공", "관리자가 학생증을 확인하고 가입을 승인할 때까지 최대 24시간이 소요될 수 있습니다.");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar("err", "upload fail");
      return false;
    }
  }

// friends services
  static Future<List<User>> fetchFriends() async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.get(Apis.fetchFriendApi, headers: {
      'Authorization': 'Bearer $token',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
      var friends = cr.data!["friends"];
      if (friends == null || friends.length == 0) {
        return [];
      }

      List<dynamic> ds = friends.map((model) => User.fromJson(model)).toList();
      List<User> friendsList = List<User>.from(ds);
      return friendsList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<List<User>> fetchRequests() async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.get(Apis.requestFriendApi, headers: {
      'Authorization': 'Bearer $token',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
      var requests = cr.data!["requests"];
      if (requests == null || requests.length == 0) {
        return [];
      }

      List<dynamic> ds = requests.map((model) => User.fromJson(model)).toList();
      List<User> friendsList = List<User>.from(ds);
      return friendsList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<bool> sendRequest(String friendName) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response =
        await RemoteServices.client.post(Apis.requestFriendApi, body: {
      "friend_name": friendName,
    }, headers: {
      'Authorization': 'Bearer $token',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (!cr.ok) {
      Get.snackbar("오류", cr.message.toString());
    }
    return cr.ok;
  }

  static Future<User?> searchFriend(String friendName) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response = await RemoteServices.client.get(
        Uri.http(Apis.baseUrl.split("/")[2], "/api/friends/search",
            {"fName": friendName}),
        headers: {
          'Authorization': 'Bearer $token',
        });
    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
      var friend = cr.data!["friend"];
      var friendData = User.fromJson(friend);
      return friendData;
    } else {
      Get.snackbar("실패", cr.message.toString());
      return null;
    }

    // return null;
  }

  static Future<bool> acceptFriend(String friendName) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);
    var response =
        await RemoteServices.client.post(Apis.acceptFriendApi, body: {
      "friend_name": friendName,
    }, headers: {
      'Authorization': 'Bearer $token',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (!cr.ok) {
      Get.snackbar("오류", cr.message.toString());
    }
    return cr.ok;
  }

// group services
  static Future<List<Group>> fetchGroups() async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.get(Apis.fetchGroupApi, headers: {
      'Authorization': 'Bearer $token',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
      var groups = cr.data!["groups"];
      if (groups == null || groups.length == 0) {
        return [];
      }

      List<dynamic> ds = groups.map((model) => Group.fromJson(model)).toList();
      List<Group> groupList = List<Group>.from(ds);
      return groupList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<List<Group>> fetchMyGroups() async {
    String uid = await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.get(Apis.fetchMyGroupApi, headers: {
      'Authorization': 'Bearer $uid',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
      var groups = cr.data!["groups"];
      if (groups == null || groups.length == 0) {
        return [];
      }

      List<dynamic> ds = groups.map((model) => Group.fromJson(model)).toList();
      List<Group> groupList = List<Group>.from(ds);
      return groupList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<bool> createGroup(
    List<String> members,
    String groupName,
    String bio,
    List<XFile> pics,
  ) async {
    try {
      // putting in uint8list format -> Upload task like a future but not future

      String token =
          await AuthController.to.firebaseUser.value!.getIdToken(false);
      var request = http.MultipartRequest("POST", Apis.createGroupApi);
      request.headers['Authorization'] = 'Bearer $token';
      for (int i = 0; i < pics.length; i++) {
        var file = await http.MultipartFile.fromPath(
          'photos', pics[i].path,
          // contentType: Mediatype('image', 'jpeg'),
        );
        request.files.add(file);
      }
      request.fields['group_name'] = groupName;
      request.fields['bio'] = bio;
      request.fields['members'] = json.encode(members);
      // request.files.addAll(await http.MultipartFile.fromPath("photos", pics.path));
      var j = await request
          .send()
          .then((res) => res.stream.bytesToString())
          .then((value) => json.decode(value));
      var res = HttpResponse.fromJson(j);

      if (res.ok) {
        // return Pic.fromJson(res.data!["pic"]);
        return res.ok;
      } else {
        Get.snackbar("사진 업로드 실패", "다시 시도해주세요! 🔧");
        return res.ok;
      }
    } catch (e) {
      print(e);
      Get.snackbar("err", "upload fail");
      return false;
    }

    // var response = await RemoteServices.client.post(Apis.createGroupApi, body: {
    //   "group_name": groupName,
    //   "members": json.encode(members),
    //   "bio": bio,
    // }, headers: {
    //   'Authorization': 'Bearer $token',
    // });

    // var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    // HttpResponse cr = HttpResponse.fromJson(clientResponse);
    // if (cr.ok) {
    //   var group = cr.data!["group"];
    //   var groupData = Group.fromJson(group);
    //   return groupData;
    // } else {
    //   Get.snackbar("실패", cr.message.toString());
    //   return null;
    // }
  }

  static Future<Pic?> uploadGroupPic(XFile file) async {
    try {
      var _file = file.path;
      // putting in uint8list format -> Upload task like a future but not future

      String token =
          await AuthController.to.firebaseUser.value!.getIdToken(false);
      var request = http.MultipartRequest("POST", Apis.uploadGroupPicApi);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath("photo", _file));
      var j = await request
          .send()
          .then((res) => res.stream.bytesToString())
          .then((value) => json.decode(value));
      var res = HttpResponse.fromJson(j);

      if (res.ok) {
        return Pic.fromJson(res.data!["pic"]);
      } else {
        Get.snackbar("사진 업로드 실패", "다시 시도해주세요! 🔧");
        return null;
      }
    } catch (e) {
      print(e);
      Get.snackbar("err", "upload fail");
      return null;
    }
  }

  static Future<bool> likeGroup(String groupName) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.post(Apis.likeGroupApi, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'group_name': groupName,
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
    } else {}

    return cr.ok;
  }

  static Future<bool> dislikeGroup(String groupName) async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.post(Apis.dislikeGroupApi, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'group_name': groupName,
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));
    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
    } else {}

    return cr.ok;
  }

  static Future<List<ChatRoom>>? fetchChatList() async {
    String token =
        await AuthController.to.firebaseUser.value!.getIdToken(false);

    var response =
        await RemoteServices.client.get(Apis.fetchChatListApi, headers: {
      'Authorization': 'Bearer $token',
    });

    var clientResponse = json.decode(utf8.decode(response.bodyBytes));

    HttpResponse cr = HttpResponse.fromJson(clientResponse);
    if (cr.ok) {
      var chatRooms = cr.data!["chat_rooms"];
      if (chatRooms == null || chatRooms.length == 0) {
        return [];
      }

      List<dynamic> ds =
          chatRooms.map((model) => ChatRoom.fromJson(model)).toList();
      List<ChatRoom> chatRoomList = List<ChatRoom>.from(ds);
      return chatRoomList;
    } else {
      throw Exception('Failed to load chat rooms');
    }
  }
}
