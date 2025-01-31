import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _getEvents() async {
    final querySnapshot = await _firestore.collection('events').get();
    return querySnapshot.docs
        .map((doc) => {
              'id': doc.id,
              'title': doc['name'],
              'date': doc['date'],
              'description': doc['description'],
              'location': doc['location'],
            })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('イベント一覧')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('イベントがありません'));
          }

          final events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                title: Text(event['title']),
                subtitle: Text(event['date']),
                onTap: () {
                  // 詳細画面に遷移するための処理
                  // ここでイベント詳細画面に渡す処理を追加
                },
              );
            },
          );
        },
      ),
    );
  }
}
