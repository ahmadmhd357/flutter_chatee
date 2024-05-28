import 'package:chatee/screens/chats_screen.dart';
import 'package:chatee/screens/contacts_screen.dart';
import 'package:chatee/screens/groups_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = const [
    ChatsScreen(),
    GroupsScreen(),
    ContactsScreen(),
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatee'),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/profile_image.png'),
          )
        ],
      ),
      body: PageView(controller: _pageController, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2), label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.group), label: 'Groups'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.globe), label: 'Contacts'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
