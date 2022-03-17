import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mocozi/controllers/auth_controller.dart';
import 'package:mocozi/model/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageController extends GetxController {
  static MessageController to = Get.find();
  final textEditingController = TextEditingController();

  static final host = dotenv.env['SOCKET_HOST'];

  late List<Message> messages = <Message>[].obs;
  late IO.Socket socket;

  final _isOnConnect = false.obs;
  set isOnConnect(value) => isOnConnect.value = value;
  get isOnConnect => _isOnConnect.value;

  final _message = ''.obs;
  set message(value) => _message.value = value;
  get message => _message.value;

  final _room = 'a'.obs;
  set room(value) => _room.value = value;
  get room => _room.value;

  final _userName = 'Flutter_client'.obs;
  set userName(value) => _userName.value = value;
  get userName => _userName.value;

  final _messageList = <String>[].obs;
  get messageList => _messageList.toList();

  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    connectSokcetIO();
  }

  onClose() {
    socket.disconnect();
    onClose();
  }

  connectSokcetIO() {
    var token = AuthController.to.firebaseUser.value!.getIdToken(true);
    socket = IO.io(
        host,
        IO.OptionBuilder()
            .setPath("/socket")
            .setTransports(["websocket"]).setExtraHeaders(
                {"Authorization": "Bearer $token"}).build());

    socket.onConnect((_) {
      print('on connect');
      socket.emit('msg', 'test');
      isOnConnect = true;
      socket.on('joined', (data) {
        print('joined');
        //room, id
        print(data.runtimeType);
        print(data);
      });
    });

    socket.on('message', (data) {
      print('message: ${data[1]}');
      // print(data.runtimeType);
      // print(data);

      final messageContent = data[1];
      _messageList.add(messageContent);
    });

    socket.onDisconnect((data) {
      print('disconnect');
      print(data);
    });

    socket.onConnectError((data) {
      print(data);
    });

    // socket.emit('join', room);
  }

  joinRoom(String roomName) {
    room = roomName;
    socket.emit("join", roomName);
  }

  sendMessage() {
    final sendData = userName + ':' + textEditingController.text;
    socket.emit('message', [room, sendData]);
    textEditingController.text = '';
  }

  disconnect() {
    socket.disconnect();
  }
}
