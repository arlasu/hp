import 'package:flutter/material.dart';

class DisplayMealScreen extends StatelessWidget {
  final String meal;
  final int calories;

  DisplayMealScreen({required this.meal, required this.calories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meal: $meal',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Calories: $calories',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
