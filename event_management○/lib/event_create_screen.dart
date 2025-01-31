import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventCreateScreen extends StatefulWidget {
  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();

  // イベントをFirestoreに保存する関数
  Future<void> _createEvent() async {
    try {
      await FirebaseFirestore.instance.collection('events').add({
        'name': _eventNameController.text,
        'date': _eventDateController.text,
        'description': _eventDescriptionController.text,
        'location': _eventLocationController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('イベントが作成されました'),
      ));
      // 作成後、元の画面に戻る
      Navigator.pop(context);
    } catch (e) {
      // エラー内容をデバッグ用にコンソールに出力
      print("Error creating event: $e"); // ここでデバッグメッセージをターミナルに表示
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('イベント作成に失敗しました: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('イベント作成')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: 'イベント名'),
            ),
            TextField(
              controller: _eventDateController,
              decoration: InputDecoration(labelText: '日程'),
            ),
            TextField(
              controller: _eventDescriptionController,
              decoration: InputDecoration(labelText: '概要'),
            ),
            TextField(
              controller: _eventLocationController,
              decoration: InputDecoration(labelText: '場所'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createEvent,
              child: Text('イベント作成'),
            ),
          ],
        ),
      ),
    );
  }
}
