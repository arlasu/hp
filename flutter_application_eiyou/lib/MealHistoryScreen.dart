import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AuthScreen.dart';
import 'MealDetailScreen.dart'; // MealDetailScreenをインポート

class MealHistoryScreen extends StatefulWidget {
  @override
  _MealHistoryScreenState createState() => _MealHistoryScreenState();
}

class _MealHistoryScreenState extends State<MealHistoryScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _selectedFilter = '日別'; // デフォルトの日別フィルタ

  // フィルタ条件に基づいてFirestoreクエリを取得
  Query _getMealQuery() {
    final now = DateTime.now();
    DateTime startDate;

    switch (_selectedFilter) {
      case '日別':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case '週別':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case '月別':
        startDate = DateTime(now.year, now.month, 1);
        break;
      default:
        startDate = DateTime(now.year, now.month, now.day);
    }

    return _firestore
        .collection('meals')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .orderBy('timestamp', descending: true);
  }

  // ログアウト処理
  void _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ログアウトしますか？'),
        content: Text('ログアウトすると再度ログインが必要になります。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false), // キャンセル
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true), // OK
            child: Text('OK'),
          ),
        ],
      ),
    );

    if (shouldLogout ?? false) {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('履歴を見る'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          // フィルタ選択のドロップダウンメニュー
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedFilter,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
              items: <String>['日別', '週別', '月別']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // 履歴表示エリア
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getMealQuery().snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  print('Firestore error: ${snapshot.error}');
                  return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
                }

                if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return _buildPlaceholder();
                }

                final mealDocs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: mealDocs.length,
                  itemBuilder: (ctx, index) {
                    final mealData =
                        mealDocs[index].data() as Map<String, dynamic>;
                    final mealName = mealData['meal'] ?? 'No Meal Name';
                    final calories = mealData['calories'] ?? 0;
                    final timestamp = mealData['timestamp']?.toDate();
                    final formattedTime = timestamp != null
                        ? '${timestamp.year}-${timestamp.month}-${timestamp.day} ${timestamp.hour}:${timestamp.minute}'
                        : '不明';

                    return ListTile(
                      title: Text(mealName),
                      subtitle: Text('カロリー: $calories\n日時: $formattedTime'),
                      onTap: () {
                        // 詳細ページに遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealDetailScreen(
                              mealData: mealData,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // プレースホルダーを構築
  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fastfood, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'まだ食事履歴がありません。',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            '「食事記録」から履歴を追加しましょう！',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
