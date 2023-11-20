import 'package:flutter/material.dart';
import 'package:second_app/screens/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigationbar.dart';

class ResultPage extends StatefulWidget {
  final int diemSo; // Số điểm của người chơi
  final int tongSoCauHoi; // Tổng số câu hỏi

  ResultPage(this.diemSo, this.tongSoCauHoi);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int diemSo; // Số điểm của người chơi (chuyển từ widget sang state)
  late int tongSoCauHoi; // Tổng số câu hỏi (chuyển từ widget sang state)

  @override
  void initState() {
    super.initState();
    diemSo = widget.diemSo;
    tongSoCauHoi = widget.tongSoCauHoi;
    saveValues();
  }

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
            const Text(
              'Điểm của bạn:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '$diemSo/$tongSoCauHoi',
              style: const TextStyle(fontSize: 32, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HoiDapPage()));
                // Truyền giá trị diemSo và tongSoCauHoi khi chuyển sang trang HoiDapPage
              },
              child: Text('Chơi Lại'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar1(), // Thêm NavigationBar vào đây
    );
  }

  void saveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    diemSo += prefs.getInt('sum_score')?? 0 ;
    prefs.setInt('sum_score', diemSo);
  }
}
