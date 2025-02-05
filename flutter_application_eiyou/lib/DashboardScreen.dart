import 'package:flutter/material.dart';
import 'MealRecordScreen.dart';
import 'MealHistoryScreen.dart';
import 'FoodSearchScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0; // 現在の選択されているタブのインデックス

  // 各タブで表示する画面のリスト
  final List<Widget> _screens = [
    MealRecordScreen(), // 食事記録画面
    MealHistoryScreen(), // 履歴画面
    FoodSearchScreen(), // 検索画面
  ];

  // タブの選択が変更されたときの処理
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ダッシュボード'),
      ),
      body: _screens[_currentIndex], // 現在選択されている画面を表示
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 現在のタブインデックス
        onTap: _onTabTapped, // タブがタップされたときに呼ばれる関数
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: '食事記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '履歴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '検索',
          ),
        ],
      ),
    );
  }
}
