import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:MOCOZI/controllers/friend_controller.dart';
import 'package:MOCOZI/controllers/group_controller.dart';
import 'package:MOCOZI/model/user.dart' as model;
import 'package:MOCOZI/pages/home_page.dart';
import 'package:MOCOZI/pages/signUp_page.dart';
import 'package:MOCOZI/pages/studentCard_page.dart';
import 'package:MOCOZI/pages/welcome_page.dart';
import 'package:MOCOZI/services/remote_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var hasPhoneNumber = false.obs;
  // var isSubmitting = false.obs;
  static AuthController to = Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<model.User> curUser = Rxn<model.User>();
  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  handleAuthChanged(User? _firebaseUser) async {
    //get user data from backend
    if (_firebaseUser == null) {
      Get.offAll(WelcomePage());
    } else {
      var me = await RemoteServices.currentUser();
      curUser.value = me;
      if (me == null) {
        return Get.offAll(SignUpPage());
      }
      switch (me.status) {
        case "phone_number_verified":
          return Get.offAll(SignUpPage());
        case "processing":
          // 회원가입 진행 중
          return Get.offAll(SignUpPage());
        case "registered":
          // 회원가입했으니 학생증 인증 안됐을 때

          return Get.offAll(StudentCardPage());
        case "pic_sent":
          // 학생증 인증 끝나고 처음 입장
          FriendController.to.getFriendsList();
          FriendController.to.getRequestsList();
          FriendController.to.getMyGroup();
          GroupController.to.fetchGroups();
          return Get.offAll(HomePage());
        case "first_time":
          // 학생증 인증 끝나고 처음 입장
          FriendController.to.getFriendsList();
          FriendController.to.getRequestsList();
          FriendController.to.getMyGroup();
          GroupController.to.fetchGroups();
          return Get.offAll(HomePage());
        case "normal":
          // 학생증 인증 끝났을 때
          FriendController.to.getFriendsList();
          FriendController.to.getRequestsList();
          FriendController.to.getMyGroup();
          GroupController.to.fetchGroups();
          return Get.offAll(HomePage());
      }
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => auth.authStateChanges();

  void signOut() async {
    await auth.signOut();
  }
}
