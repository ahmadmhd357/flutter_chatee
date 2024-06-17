import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nameController = TextEditingController();

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
          const Center(
            child: Stack(
              children: [
                CircleAvatar(
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
                    child: Icon(
                      Icons.camera_alt,
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
