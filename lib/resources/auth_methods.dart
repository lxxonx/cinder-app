import 'dart:typed_data';

import 'package:cinder/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinder/models/user.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String uni,
    required String dep,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          uni.isNotEmpty ||
          dep.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          uni: uni,
          dep: dep,
          email: email,
          bio: "",
          profilePics: [],
          friends: [],
          friendsReq: [],
          likeTo: [],
          likeFrom: [],
          saves: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      if (err.toString().contains("weak-password")) {
        // TODO
        // add toast
      }
      return err.toString();
    }
    return res;
  }

  // Future<String> uploadPics({
  //   required List<String> downloadUrl,
  // }) {

  //   return "return";
  // }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> getCurrentUser() async {
    if (_auth.currentUser != null) {
      String? token = await _auth.currentUser?.getIdToken();
      return token;
    } else {
      return null;
    }
  }
}
