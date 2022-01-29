import 'dart:typed_data';

import 'package:cinder/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinder/models/user.dart' as model;
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<String> googleSignIn() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await account!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    currentUser = _auth.currentUser;
    assert(user!.uid == currentUser!.uid);

    return '구글 로그인 성공: $user';
  }

  void googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    print("User Sign Out");
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
