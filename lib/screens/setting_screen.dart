import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
   bool isDarkTheme = false;

  void getThemeMode() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      setState(
        () {
          isDarkTheme = true;
        },
      );
    } else {
      setState(() {
        isDarkTheme = false;
      });
    }
  }

  @override
  void initState() {
    getThemeMode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}