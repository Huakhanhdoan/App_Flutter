import 'package:flutter/material.dart';
import 'package:second_app/screens/quiz.dart';

class ResultPage extends StatelessWidget {
  final int diemSo; // Số điểm của người chơi
  final int tongSoCauHoi; // Tổng số câu hỏi

  ResultPage(this.diemSo, this.tongSoCauHoi);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết Quả'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Điểm của bạn:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '$diemSo/$tongSoCauHoi',
              style: TextStyle(fontSize: 32, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {

                // Thực hiện hành động nào đó khi người chơi muốn chơi lại
              },
              child: Text('Chơi Lại'),
            ),
          ],
        ),
      ),
    );
  }
}
