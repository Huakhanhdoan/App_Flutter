import 'package:flutter/material.dart';
import 'package:second_app/screens/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Chủ'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Điều hướng đến trang cài đặt
            },
          ),
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              // Điều hướng đến trang xếp hạng
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Điều hướng đến trang thông tin cá nhân
            },
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Điều hướng đến trang trợ giúp
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/map.png', // Thay đổi đường dẫn hình bản đồ
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 125,
            top: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HoiDapPage()));
              },
              child: Text('Bắc'),
            ),
          ),
          Positioned(
            left: 180,
            top: 250,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HoiDapPage()));
              },
              child: Text('Trung'),
            ),
          ),
          Positioned(
            left: 180,
            top: 380,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HoiDapPage()));
              },
              child: Text('Nam'),
            ),
          ),
        ],
      ),
    );
  }
}
