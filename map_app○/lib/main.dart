import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart'; // 自動生成されたオプションファイル

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstLogin', true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansJpTextTheme(), // 全体のフォントに適用
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
