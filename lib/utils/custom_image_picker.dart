import 'dart:io';
import 'package:image_picker/image_picker.dart';


class CustomImagePicker {
  static final ImagePicker  _picker = ImagePicker();
  //get image from device
  static Future <File> getImageFromDevice() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 640, maxHeight: 480);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('File not found');
    }
  }

  //get image from camera
  static Future <File> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, maxWidth: 640, maxHeight: 480);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('File not found');
    }
  }

}