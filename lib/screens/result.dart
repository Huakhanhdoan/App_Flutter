import 'package:flutter/material.dart';
import 'package:second_app/screens/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../audio/audio.dart';
import 'navigationbar.dart';

class ResultPage extends StatefulWidget {
  final int diemSo; // Số điểm của người chơi
  final String location;

  ResultPage(this.diemSo, this.location);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int diemSo; // Số điểm của người chơi (chuyển từ widget sang state)
  late int tongSoCauHoi; // Tổng số câu hỏi (chuyển từ widget sang state)
  String path = "";
  String _location = "";
  String nextLocation = "";
  AudioManager _audioManager = new AudioManager();

  @override
  void initState() {
    super.initState();
    _audioManager.playSound('result');
    diemSo = widget.diemSo;
    path = check_huyChuong();
    nextLocation = next_Location();
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
            image: AssetImage('assets/images/bg_basic.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Điểm của bạn:',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '$diemSo' '/10',
                  style: const TextStyle(
                      fontSize: 32,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (diemSo >= 8)
                Column(
                  children: [
                    Text(
                      'Nhận huy hiệu miền ' '${widget.location}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                    Image.asset(
                      path,
                      width: 100,
                      height: 100,
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      'Cố lên!',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HoiDapPage(widget.location)));

                        },
                        icon: Icon(Icons.repeat),
                        label: Text("Chơi lại"))
                  ],
                ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  nextLocation != ""
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HoiDapPage(nextLocation)))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HoiDapPage("Bắc")));
                  // Truyền giá trị diemSo và tongSoCauHoi khi chuyển sang trang HoiDapPage
                },
                icon: Icon(Icons.next_plan),
                label: const Text('Địa điểm tiếp theo'),
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

  String next_Location() {
    if (widget.location == "Bắc") {
      return "Trung";
    }
    if (widget.location == "Trung") {
      return "Nam";
    }
    return "End";
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
