import 'package:flutter/material.dart';
import 'package:second_app/question.dart';

class HoiDapPage extends StatefulWidget {
  @override
  _HoiDapPageState createState() => _HoiDapPageState();
}

class _HoiDapPageState extends State<HoiDapPage> {
  int diemSo = 0;

  int cauHienTai = 0;
  bool isChoose= false;
  Color c1 = Colors.white;
  Color c2 = Colors.white;
  Color c3 = Colors.white;
  Color c4 = Colors.white;

  Color diem = Colors.yellowAccent;
  double font_size = 20;
  List<Question> danhSachCauHoi = [];

  @override
  void initState() {
    super.initState();
    docCauHoi();

  }

  void docCauHoi() async {
    danhSachCauHoi = await Question.docTuJson('assets/JSON/list_question.json');
    setState(() {
    });
  }
void chuyenCauHoi() {
  diem = Colors.yellowAccent;
  font_size = 20;
    isChoose = false;
    cauHienTai++;
    setState(() {
      c1 = Colors.white;
      c2 = Colors.white;
      c3 = Colors.white;
      c4 = Colors.white;

    });

}
  void xuLyTraLoi( int cauhientai, int luaChon) {
    if(!isChoose) {
      diem = Colors.amber;
      font_size = 24;
      isChoose = true;
      int dapAn = danhSachCauHoi[cauhientai].dapAnDung;
      setState(() {
        if (luaChon == dapAn) {
          diemSo++;
        } else {
          switch (luaChon) {
            case 1:
              c1 = Colors.red;
              break;
            case 2:
              c2 = Colors.red;
              break;
            case 3:
              c3 = Colors.red;
              break;
            case 4:
              c4 = Colors.red;
              break;
          }
        }
        switch (dapAn) {
          case 1:
            c1 = Colors.green;
            break;
          case 2:
            c2 = Colors.green;
            break;
          case 3:
            c3 = Colors.green;
            break;
          case 4:
            c4 = Colors.green;
            break;
        }
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    if (danhSachCauHoi.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    Question cauHoi = danhSachCauHoi[cauHienTai];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chưa nghĩ ra tên'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Điểm số: $diemSo',
                style: TextStyle(fontSize: font_size, color: diem), // Thay đổi kích thước chữ
              ),
            ),
          ),
        ],

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Câu hỏi ${cauHienTai + 1}: ${cauHoi.cauHoi}',
              style: const TextStyle(fontSize: 18),
            ),
            Container(
              width: 350.0, // Chiều rộng của hình ảnh
              height: 150.0, // Chiều cao của hình ảnh
              child: Image.asset(cauHoi.hinhAnh),
            ),




            ListTile(
                title: Text(cauHoi.luaChon[0]),
                tileColor: c1,

                onTap:
                () => xuLyTraLoi(cauHienTai,1),
              ),
            ListTile(
              title: Text(cauHoi.luaChon[1]),
              tileColor: c2,

              onTap:
                  () => xuLyTraLoi(cauHienTai,2),
            ),
            ListTile(
              title: Text(cauHoi.luaChon[2]),
              tileColor: c3,

              onTap:
                  () => xuLyTraLoi(cauHienTai,3),
            ),
            ListTile(
              title: Text(cauHoi.luaChon[3]),
              tileColor: c4,

              onTap:
                  () => xuLyTraLoi(cauHienTai,4),
            ),
            ElevatedButton(
              onPressed: chuyenCauHoi, // Hàm này sẽ chuyển sang câu hỏi tiếp theo
              child: Text('Câu tiếp theo'),
            ),
          ],
        ),
      ),
    );
  }
}
