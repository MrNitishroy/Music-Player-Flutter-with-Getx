import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Pages/splace_page.dart';
import 'package:music_player/config/my_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: darkTheme,
      darkTheme: darkTheme,
      home: SpalcePage(),
    );
  }
}
