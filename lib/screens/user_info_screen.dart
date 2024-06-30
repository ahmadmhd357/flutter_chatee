import 'dart:io';

import 'package:chatee/methods/methods.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nameController = TextEditingController();

  File? imageFile;
  String userImage = '';

  void showImageModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                selectProfileImage(true);
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
            ),
            ListTile(
              onTap: () {
                selectProfileImage(false);
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  void selectProfileImage(bool fromCamera) async {
    imageFile = await imagePicker(
      fromCamera: fromCamera,
      onFail: (String message) {
        showSnackBar(context, message);
      },
    );
    if (imageFile != null) {
      cropImage(imageFile!.path);
    }
  }

  void cropImage(String filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 800,
      maxWidth: 800,
      compressQuality: 99,
    );
    if (croppedFile != null) {
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
    popDailoge();
  }

  void popDailoge() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User information"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(
              children: [
                imageFile != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(imageFile!.path)),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage('assets/images/profile_image.png'),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 20,
                    child: IconButton(
                      onPressed: () {
                        showImageModalSheet(context);
                      },
                      icon: const Icon(Icons.camera_alt),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  _nameController.text = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter your name',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: _nameController.text.length < 3 ? null : () {},
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
