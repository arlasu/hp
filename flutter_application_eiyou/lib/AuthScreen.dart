import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DashboardScreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  String name = ''; // 名前を保存する変数
  bool isLogin = true;

  Future<void> _submitAuthForm() async {
    try {
      if (isLogin) {
        // ログイン処理
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // 新規ユーザー登録処理
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // ユーザーが作成された後、Firestoreに名前を保存
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'name': name, // 名前をFirestoreに保存
          'email': email,
          'createdAt': FieldValue.serverTimestamp(), // 登録日時
        });
      }

      // ログインまたは登録後にダッシュボードに遷移
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } catch (error) {
      print('Error details: ${error.toString()}');
      String errorMessage = 'エラーが発生しました。';

      // エラー内容に基づいて日本語メッセージを設定
      if (error.toString().contains('email')) {
        errorMessage = 'メールアドレスに誤りがあります。';
      } else if (error.toString().contains('password')) {
        errorMessage = 'パスワードが間違っています。';
      } else if (error.toString().contains('user-not-found')) {
        errorMessage = 'ユーザーが見つかりません。';
      } else if (error.toString().contains('network-request-failed')) {
        errorMessage = 'ネットワーク接続に失敗しました。';
      }

      // エラーを表示するダイアログ
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('エラー'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('閉じる'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'ログイン' : 'ユーザー登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!isLogin) // 新規登録時のみ名前を入力させる
              TextField(
                decoration: InputDecoration(labelText: '名前'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            TextField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'パスワード'),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAuthForm,
              child: Text(isLogin ? 'ログイン' : 'ユーザー登録'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin ? '新規登録' : 'ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
