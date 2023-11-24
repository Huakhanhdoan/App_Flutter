import 'package:flutter/material.dart';
import 'package:second_app/screens/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/audio.dart';
import 'navigationbar.dart';

class ResultPage extends StatefulWidget {
  final int diemSo; // Số điểm của người chơi
  final int tongSoCauHoi; // Tổng số câu hỏi
  final String location;

  ResultPage(this.diemSo, this.tongSoCauHoi, this.location);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int diemSo; // Số điểm của người chơi (chuyển từ widget sang state)
  late int tongSoCauHoi; // Tổng số câu hỏi (chuyển từ widget sang state)
  String path = "";
  String _location = "";
  AudioManager _audioManager = new AudioManager();

  @override
  void initState() {
    super.initState();
    _audioManager.playSound('result');
    diemSo = widget.diemSo;
    tongSoCauHoi = widget.tongSoCauHoi;
    path = check_huyChuong();
    if (widget.location == "Bắc") {
      _location = "bac";
    }
    if (widget.location == "Trung") {
      _location = "trung";
    }
    if (widget.location == "Nam") {
      _location = "nam";
    }
    saveValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Kết quả'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                // Xử lý khi bấm vào icon trợ giúp
              },
            ),
          ]),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Điểm của bạn:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '$diemSo/$tongSoCauHoi',
                style: const TextStyle(
                    fontSize: 32,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Nhận huy hiệu miền ' '${widget.location}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (path != "")
                Image.asset(
                  path,
                  width: 100,
                  height: 100,
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HoiDapPage("Bắc")));
                  // Truyền giá trị diemSo và tongSoCauHoi khi chuyển sang trang HoiDapPage
                },
                child: Text('Chơi Lại'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar1(), // Thêm NavigationBar vào đây
    );
  }

  void saveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    diemSo += prefs.getInt('sum_score') ?? 0;
    prefs.setInt('sum_score', diemSo);
    prefs.setBool(_location, true);
  }

  String check_huyChuong() {
    if (widget.location == "Bắc") {
      return "assets/images/huychuong1.png";
    }
    if (widget.location == "Trung") {
      return "assets/images/huychuong2.png";
    }
    return "assets/images/huychuong3.png";
  }
}
