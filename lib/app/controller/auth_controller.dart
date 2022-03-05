import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocozi/app/const/universities.dart';
import 'package:mocozi/app/models/group.dart';
import 'package:mocozi/app/services/auth_services.dart';
import 'package:mocozi/app/services/remote_services.dart';
import 'package:mocozi/app/views/pages/login_page.dart';
import 'package:mocozi/app/views/pages/home_page.dart';
import 'package:mocozi/app/views/pages/signup_page.dart';
import 'package:mocozi/app/views/pages/welcome_page.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var hasPhoneNumber = false.obs;
  // var isSubmitting = false.obs;
  static AuthController to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  var uni = "대학교를 선택하세요".obs;
  var dep = "단과대를 선택하세요".obs;
  var gender = "성별을 선택하세요".obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController birthYearContoller = TextEditingController();
  TextEditingController actualNameController = TextEditingController();

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController currController = TextEditingController();

  FocusNode controller1fn = FocusNode();
  FocusNode controller2fn = FocusNode();
  FocusNode controller3fn = FocusNode();
  FocusNode controller4fn = FocusNode();
  FocusNode controller5fn = FocusNode();
  FocusNode controller6fn = FocusNode();
  String phoneNumber = "";

  String _verificationId = "";

  void selectUni(context) {
    List<String> unis = [
      "대학교를 선택하세요",
    ];
    unis.addAll(universities);

    List<Widget> uniOptionBuilder() {
      List<Widget> res = [];
      for (var uni in unis) {
        res.add(Text(uni));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                uni.value = unis[selected];
              },
              useMagnifier: true,
              backgroundColor: Colors.white,
              magnification: 1.5,
              children: uniOptionBuilder(),
            ),
          ),
        ]);
      },
    );
  }

  void selectDep(context) {
    List<String> departments = [
      "단과대를 선택하세요",
      "Action One",
      "Action Two",
      "Action Three",
      "Action Four",
    ];

    List<Widget> depOptionBuilder() {
      List<Widget> res = [];
      for (var dep in departments) {
        res.add(Text(dep));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 300,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                dep.value = departments[selected];
              },
              useMagnifier: true,
              backgroundColor: Colors.white,
              magnification: 1.5,
              children: depOptionBuilder(),
            ),
          ),
        ]);
      },
    );
  }

  void selectGender(context) {
    List<String> genders = [
      "성별을 선택하세요",
      "여성",
      "남성",
      "기타",
    ];

    List<Widget> genderOptionBuilder() {
      List<Widget> res = [];
      for (var g in genders) {
        res.add(Text(g));
      }
      return res;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(actions: [
          Container(
            height: 180,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (selected) {
                gender.value = genders[selected];
              },
              useMagnifier: true,
              backgroundColor: Colors.white,
              magnification: 1.5,
              children: genderOptionBuilder(),
            ),
          ),
        ]);
      },
    );
  }

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();

    birthYearContoller.dispose();
    actualNameController.dispose();

    currController.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    super.onClose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<UserCredential> signUpWithGoogle() async {
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
    return await _auth.signInWithCredential(credential);
  }

  handleAuthChanged(User? _firebaseUser) async {
    //get user data from backend

    print("userinfo: " + _firebaseUser.toString());

    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(WelcomePage());
    } else {
      if (_firebaseUser.displayName == null) {
        return Get.offAll(SignupPage());
      }
      Get.offAll(HomePage());
    }
  }

  // ignore: non_constant_identifier_names
  void Login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username == "" || password == "") {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      Get.snackbar(userCredential.toString(), 'auth.signInError'.tr,
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
    if (dep == "단과대를 선택하세요") {
      // toast
      Get.snackbar('Error', '학과를 선택해주세요',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
      return;
    }
    if (uni == "대학교를 선택하세요") {
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
        username: usernameController.text,
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

  void signUpWithPhoneNumber() async {
    phoneNumber = phoneController.text.trim();
    String phoneNumberWithCountryCode = "+82" + phoneNumber.substring(1);

    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumberWithCountryCode,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Home()),
              //     (route) => false);
              print("loggedin");
            }
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.code);
          print(authException.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          print("code sent");
          _verificationId = verificationId;
          isLoading.value = false;
          Get.toNamed("/verifyCode");
          hasPhoneNumber.value = false;
          currController = controller1;
          print(_verificationId);
        },
        timeout: const Duration(minutes: 2),
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  void verifyCode() async {
    isLoading.value = true;
    if (controller1.text.trim() == "" ||
        controller2.text.trim() == "" ||
        controller3.text.trim() == "" ||
        controller4.text.trim() == "" ||
        controller5.text.trim() == "" ||
        controller6.text.trim() == "") {
      Get.snackbar('Error', '올바른 인증 코드를 입력해주세요',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10));
      // Utility.showToast(msg: "Please enter valid verification code.");
    } else {
      var otp = (controller1.text.trim() +
          controller2.text.trim() +
          controller3.text.trim() +
          controller4.text.trim() +
          controller5.text.trim() +
          controller6.text.trim());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: otp);

        print(credential.providerId);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            // Get.offNamed("/home");
          } else {
            // Utility.showToast(msg: "Sign in failed");
            Get.snackbar('Error', '로그인에 실패했습니다',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                borderRadius: 10,
                margin: EdgeInsets.all(10));
          }
        });
      } catch (e) {
        print(e);

        // Utility.showToast(msg: e.toString());
        // _showProgressDialog(false);
      }
    }

    isLoading.value = false;
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
