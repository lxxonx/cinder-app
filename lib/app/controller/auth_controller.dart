import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/services/auth_services.dart';
import 'package:mocozi/app/services/remote_services.dart';
import 'package:mocozi/app/views/pages/login_page.dart';
import 'package:mocozi/app/views/pages/home_page.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;
  static AuthController to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  String uni = "Select University";
  String dep = "Select Department";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    print(googleUser);
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from backend
    if (_firebaseUser?.uid != null) {}
    print(_firebaseUser);

    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(LoginPage());
    } else {
      Get.offAll(HomePage());
    }
  }

  // ignore: non_constant_identifier_names
  void Login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("error" + e.toString());
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  void signUp() async {
    if (dep == "Select Department") {
      // toast
      Get.snackbar('Error', '학과를 선택해주세요',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
      return;
    }
    if (uni == "Select University") {
      // toast
      Get.snackbar('Error', '대학교를 선택해주세요',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
      return;
    }
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
    }
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // .set(_user.toJson());
      print(cred.user!.uid);
      await AuthServices.register(
        uid: cred.user!.uid,
        email: emailController.text,
        password: passwordController.text,
        username: nameController.text,
        uni: uni,
        dep: dep,
      );
    } catch (err) {
      if (err.toString().contains("weak-password")) {
        // TODO
        // add toast
      }
      print(err.toString());
    }
  }
  // //Streams the firestore user from the firestore collection
  // Stream<UserModel> streamFirestoreUser() {
  //   print('streamFirestoreUser()');

  //   return _db
  //       .doc('/users/${firebaseUser.value!.uid}')
  //       .snapshots()
  //       .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  // }

  // //get the firestore user from the firestore collection
  // Future<UserModel> getFirestoreUser() {
  //   return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
  //       (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  // }

  // //Method to handle user sign in using email and password
  // signInWithEmailAndPassword(BuildContext context) async {
  //   showLoadingIndicator();
  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim());
  //     emailController.clear();
  //     passwordController.clear();
  //     hideLoadingIndicator();
  //   } catch (error) {
  //     hideLoadingIndicator();
  //     Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 7),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }

  // // User registration using email and password
  // registerWithEmailAndPassword(BuildContext context) async {
  //   showLoadingIndicator();
  //   try {
  //     await _auth
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text, password: passwordController.text)
  //         .then((result) async {
  //       print('uID: ' + result.user!.uid.toString());
  //       print('email: ' + result.user!.email.toString());
  //       //get photo url from gravatar if user has one
  //       Gravatar gravatar = Gravatar(emailController.text);
  //       String gravatarUrl = gravatar.imageUrl(
  //         size: 200,
  //         defaultImage: GravatarImage.retro,
  //         rating: GravatarRating.pg,
  //         fileExtension: true,
  //       );
  //       //create the new user object
  //       UserModel _newUser = UserModel(
  //           uid: result.user!.uid,
  //           email: result.user!.email!,
  //           name: nameController.text,
  //           photoUrl: gravatarUrl);
  //       //create the user in firestore
  //       _createUserFirestore(_newUser, result.user!);
  //       emailController.clear();
  //       passwordController.clear();
  //       hideLoadingIndicator();
  //     });
  //   } on FirebaseAuthException catch (error) {
  //     hideLoadingIndicator();
  //     Get.snackbar('auth.signUpErrorTitle'.tr, error.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 10),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }

  // //handles updating the user when updating profile
  // Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
  //     String password) async {
  //   String _authUpdateUserNoticeTitle = 'auth.updateUserSuccessNoticeTitle'.tr;
  //   String _authUpdateUserNotice = 'auth.updateUserSuccessNotice'.tr;
  //   try {
  //     showLoadingIndicator();
  //     try {
  //       await _auth
  //           .signInWithEmailAndPassword(email: oldEmail, password: password)
  //           .then((_firebaseUser) async {
  //         await _firebaseUser.user!
  //             .updateEmail(user.email)
  //             .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
  //       });
  //     } catch (err) {
  //       print('Caught error: $err');
  //       //not yet working, see this issue https://github.com/delay/flutter_starter/issues/21
  //       if (err.toString() ==
  //           "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
  //         _authUpdateUserNoticeTitle = 'auth.updateUserEmailInUse'.tr;
  //         _authUpdateUserNotice = 'auth.updateUserEmailInUse'.tr;
  //       } else {
  //         _authUpdateUserNoticeTitle = 'auth.wrongPasswordNotice'.tr;
  //         _authUpdateUserNotice = 'auth.wrongPasswordNotice'.tr;
  //       }
  //     }
  //     hideLoadingIndicator();
  //     Get.snackbar(_authUpdateUserNoticeTitle, _authUpdateUserNotice,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 5),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   } on PlatformException catch (error) {
  //     //List<String> errors = error.toString().split(',');
  //     // print("Error: " + errors[1]);
  //     hideLoadingIndicator();
  //     print(error.code);
  //     String authError;
  //     switch (error.code) {
  //       case 'ERROR_WRONG_PASSWORD':
  //         authError = 'auth.wrongPasswordNotice'.tr;
  //         break;
  //       default:
  //         authError = 'auth.unknownError'.tr;
  //         break;
  //     }
  //     Get.snackbar('auth.wrongPasswordNoticeTitle'.tr, authError,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 10),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }

}
