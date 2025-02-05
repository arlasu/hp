import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'AuthScreen.dart'; // AuthScreenのインポート
import 'firebase_options.dart'; // Firebaseの設定オプションのインポート

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '栄養管理アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(), // 最初にログイン画面を表示
    );
  }
}
