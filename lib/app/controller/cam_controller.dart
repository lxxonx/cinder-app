import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocozi/app/services/auth_services.dart';

class CamController extends GetxController {
  var isLoading = false.obs;
  var isCardSent = false.obs;
  static CamController get to => Get.find();
  final _picker = ImagePicker();

  Future<void> uploadStudentCard() async {
    final _pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (_pickedFile != null) {
      isLoading(true);
      await AuthServices.uploadStudentCard(_pickedFile);
      update();
    } else {
      print('No image selected.');
    }
    isLoading(false);
  }

  // Future<void> preview() async {
  //   File image;
  //   String imagePath;
  //   final pickedFile = await _picker.pickVideo(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //     imagePath = pickedFile.path;
  //     print(imagePath);
  //     update();
  //   } else {
  //     print('No image selected.');
  //   }
  // }
}
