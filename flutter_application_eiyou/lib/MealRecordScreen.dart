import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AuthScreen.dart'; // ログイン画面への遷移用

class MealRecordScreen extends StatefulWidget {
  final String? productName;
  final String? calories;
  final String? protein; // 追加
  final String? fat; // 追加
  final String? sugar; // 追加
  final String? fiber; // 追加
  final String? salt; // 追加

  MealRecordScreen({
    this.productName,
    this.calories,
    this.protein,
    this.fat,
    this.sugar,
    this.fiber,
    this.salt,
  });

  @override
  _MealRecordScreenState createState() => _MealRecordScreenState();
}

class _MealRecordScreenState extends State<MealRecordScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String meal = '';
  int calories = 0;
  double sugar = 0; // 糖質
  double fiber = 0; // 食物繊維
  double salt = 0; // 塩分
  String timeOfDay = '朝'; // 食事の時間帯

  final TextEditingController mealController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();
  final TextEditingController fiberController = TextEditingController();
  final TextEditingController saltController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();

    // 受け取ったパラメータで初期化
    if (widget.productName != null && widget.calories != null) {
      meal = widget.productName!;
      calories = int.tryParse(widget.calories!) ?? 0;
      mealController.text = meal;
      caloriesController.text = calories.toString();
    }
    if (widget.sugar != null) {
      sugar = double.tryParse(widget.sugar!) ?? 0;
      sugarController.text = sugar.toString();
    }
    if (widget.fiber != null) {
      fiber = double.tryParse(widget.fiber!) ?? 0;
      fiberController.text = fiber.toString();
    }
    if (widget.salt != null) {
      salt = double.tryParse(widget.salt!) ?? 0;
      saltController.text = salt.toString();
    }
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print('現在のユーザーID: ${loggedInUser!.uid}'); // ログ確認
    } else {
      print('ユーザーがログインしていません');
    }
  }

  Future<void> _addMeal() async {
    try {
      if (meal.isEmpty || calories == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('食品名とカロリーを入力してください'),
        ));
        return;
      }

      if (loggedInUser == null) {
        throw Exception('ユーザーがログインしていません');
      }

      final mealData = {
        'meal': meal,
        'calories': calories,
        'sugar': sugar,
        'fiber': fiber,
        'salt': salt,
        'timeOfDay': timeOfDay,
        'userId': loggedInUser!.uid,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('meals').add(mealData);

      setState(() {
        meal = '';
        calories = 0;
        sugar = 0;
        fiber = 0;
        salt = 0;
        mealController.clear();
        caloriesController.clear();
        sugarController.clear();
        fiberController.clear();
        saltController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('食事が追加されました！'),
      ));
    } catch (error, stackTrace) {
      print('エラーが発生しました: $error');
      print('詳細: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('エラーが発生しました: $error'),
      ));
    }
  }

  Future<void> _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ログアウトしますか？'),
        content: Text('ログアウトすると、再度ログインが必要になります。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('食事記録'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: '食品名'),
              controller: mealController,
              onChanged: (value) {
                setState(() {
                  meal = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'カロリー'),
              keyboardType: TextInputType.number,
              controller: caloriesController,
              onChanged: (value) {
                setState(() {
                  calories = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: '糖質 (g)'),
              keyboardType: TextInputType.number,
              controller: sugarController,
              onChanged: (value) {
                setState(() {
                  sugar = double.tryParse(value) ?? 0;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: '食物繊維 (g)'),
              keyboardType: TextInputType.number,
              controller: fiberController,
              onChanged: (value) {
                setState(() {
                  fiber = double.tryParse(value) ?? 0;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: '塩分 (g)'),
              keyboardType: TextInputType.number,
              controller: saltController,
              onChanged: (value) {
                setState(() {
                  salt = double.tryParse(value) ?? 0;
                });
              },
            ),
            DropdownButton<String>(
              value: timeOfDay,
              onChanged: (value) {
                setState(() {
                  timeOfDay = value!;
                });
              },
              items:
                  ['朝', '昼', '晩'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMeal,
              child: Text('食事を追加'),
            ),
          ],
        ),
      ),
    );
  }
}
