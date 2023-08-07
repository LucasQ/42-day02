import 'package:flutter/material.dart';

class WeeklyTab extends StatelessWidget {
  final String title;

  const WeeklyTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
