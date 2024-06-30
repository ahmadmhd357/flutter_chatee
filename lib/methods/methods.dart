import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<File?> imagePicker({
  required bool fromCamera,
  required Function(String) onFail,
}) async {
  File? pickedImage;
  if (fromCamera) {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        onFail('no image selected');
      } else {
        pickedImage = File(pickedFile.path);
      }
    } catch (e) {
      onFail(e.toString());
    }
  } else {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        onFail('no image selected');
      } else {
        pickedImage = File(pickedFile.path);
      }
    } catch (e) {
      onFail(e.toString());
    }
  }
  return pickedImage;
}
