import 'package:chatee/auth/login_screen.dart';
import 'package:chatee/auth/otp_screen.dart';
import 'package:chatee/providers/auth_provider.dart';
import 'package:chatee/screens/home_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:chatee/screens/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: MyApp(savedThemeMode: savedThemeMode),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'chatee',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: const UserInfoScreen(),
      ),
    );
  }
}
