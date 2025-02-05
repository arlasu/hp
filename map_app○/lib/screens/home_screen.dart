import 'package:flutter/material.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuthをインポート
import '../services/firebase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppleMapController mapController;
  final FirebaseService _firebaseService = FirebaseService();
  Set<Annotation> _annotations = {}; // 地図に表示するピン

  @override
  void initState() {
    super.initState();
    _listenToPins(); // Firestoreのピンデータをリアルタイムで取得
  }

  // Firestoreからピンをリアルタイムで取得
  void _listenToPins() {
    _firebaseService.getPins('user_id').listen((snapshot) {
      final newAnnotations = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Annotation(
          annotationId: AnnotationId(doc.id),
          position: LatLng(data['latitude'], data['longitude']),
          infoWindow: InfoWindow(
            title: data['title'],
            snippet: '保存されたピン',
          ),
        );
      }).toSet();

      setState(() {
        _annotations = newAnnotations; // ピンのセットを更新
      });
    });
  }

  // マップが作成された際に呼び出される
  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  // 地図を長押ししてピンを追加する
  void _onLongPress(LatLng position) {
    final TextEditingController _titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('保存場所の名前'),
          content: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'タイトルを入力してください',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty) {
                  // タイトルを入力してピンを保存
                  await _addPin(position, _titleController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('タイトルを入力してください。')),
                  );
                }
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  // ピンをFirestoreに保存する
  Future<void> _addPin(LatLng position, String title) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is logged in");
      return;
    }

    try {
      // ピン追加のログを表示
      print(
          "Attempting to add pin: $title at ${position.latitude}, ${position.longitude}");

      // Firestoreにピンを保存
      await _firebaseService.addPin(
        user.uid, // ユーザーIDを動的に取得
        title,
        position.latitude,
        position.longitude,
      );
      print("Pin added successfully");
    } catch (e) {
      print("Error adding pin: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Maps - ピン表示'),
      ),
      body: AppleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(35.681236, 139.767125), // 東京駅の初期位置
          zoom: 12.0,
        ),
        annotations: _annotations, // Firestoreから取得したピンを表示
        onLongPress: _onLongPress, // 地図を長押ししてピン追加ポップアップを表示
      ),
    );
  }
}
