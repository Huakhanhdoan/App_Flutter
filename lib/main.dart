import 'package:flutter/material.dart';
import 'quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng Hỏi Đáp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HoiDapPage(),
    );
  }
}
