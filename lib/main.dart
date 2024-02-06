import 'package:flutter/material.dart';
import 'package:magic_hat/utils/shared_preferences/shared_preferences.dart';
import 'navigator_bar/navigator_bar.dart';

void main() async {
  MagicSharedPreferences magicSharedPreferences = MagicSharedPreferences();
  await magicSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NavigatorBar(),
    );
  }
}
