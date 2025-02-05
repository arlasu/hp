import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  final Map<String, dynamic> mealData;

  MealDetailScreen({required this.mealData});

  @override
  Widget build(BuildContext context) {
    final mealName = mealData['meal'] ?? 'No Meal Name';
    final calories = mealData['calories'] ?? 0;
    final sugar = mealData['sugar'] ?? 0;
    final fiber = mealData['fiber'] ?? 0;
    final salt = mealData['salt'] ?? 0;
    final timeOfDay = mealData['timeOfDay'] ?? '不明';
    final timestamp = mealData['timestamp']?.toDate();
    final formattedTime = timestamp != null
        ? '${timestamp.year}-${timestamp.month}-${timestamp.day} ${timestamp.hour}:${timestamp.minute}'
        : '不明';

    return Scaffold(
      appBar: AppBar(title: Text('$mealName の詳細')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('食品名: $mealName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('カロリー: $calories kcal', style: TextStyle(fontSize: 18)),
            Text('糖質: $sugar g', style: TextStyle(fontSize: 18)),
            Text('食物繊維: $fiber g', style: TextStyle(fontSize: 18)),
            Text('塩分: $salt g', style: TextStyle(fontSize: 18)),
            Text('時間帯: $timeOfDay', style: TextStyle(fontSize: 18)),
            Text('記録日時: $formattedTime', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
