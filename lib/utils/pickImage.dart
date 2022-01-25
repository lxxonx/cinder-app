import 'package:image_picker/image_picker.dart';

PickImage(ImageSource imgSrc) async {
  final ImagePicker _picker = ImagePicker();

  XFile? _file = await _picker.pickImage(source: imgSrc);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("no file selected!");
}
