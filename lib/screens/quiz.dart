import 'package:flutter/material.dart';
import 'package:second_app/model/question.dart';
import 'package:second_app/model/quiz_model.dart';

class HoiDapPage extends StatefulWidget {
  @override
  _HoiDapPageState createState() => _HoiDapPageState();
}

class _HoiDapPageState extends State<HoiDapPage> {
  final QuizModel model = QuizModel();
  List<Question> danhSachCauHoi = [];

  void docCauHoi() async {
    danhSachCauHoi = await Question.docTuJson('./assets/JSON/list_question.json');
    print('Số lượng câu hỏi: ${danhSachCauHoi.length}');
    setState(() {

    });

  }
  @override
  void initState() {
    super.initState();
   docCauHoi();
  }

  @override
  Widget build(BuildContext context) {


    if (danhSachCauHoi.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    Question cauHoi = danhSachCauHoi[model.cauHienTai];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tên ứng dụng'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.greenAccent, // Đặt màu nền
                  borderRadius: BorderRadius.circular(30), // Đặt góc bo tròn
                ),
                child: Center(
                  child: Text(
                    'Điểm: ${model.diemSo}',
                    style: TextStyle(fontSize: model.font_size, color: model.color_diem),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Câu hỏi ${model.cauHienTai + 1}: ${cauHoi.cauHoi}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
            const SizedBox(height: 20),
            Container(
              width: 350.0,
              height: 150.0,
              child: Image.asset(cauHoi.hinhAnh),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(cauHoi.luaChon[0]),
              tileColor: model.c1,
              onTap: () {
                model.xuLyTraLoi(1,danhSachCauHoi[model.cauHienTai]);
                setState(() {}); // Cập nhật trạng thái
              },
            ),
            ListTile(
              title: Text(cauHoi.luaChon[1]),
              tileColor: model.c2,
              onTap: () {
                model.xuLyTraLoi(2,danhSachCauHoi[model.cauHienTai]);
                setState(() {}); // Cập nhật trạng thái
              },
            ),
            ListTile(
              title: Text(cauHoi.luaChon[2]),
              tileColor: model.c3,
              onTap: () {
                model.xuLyTraLoi(3,danhSachCauHoi[model.cauHienTai]);
                setState(() {}); // Cập nhật trạng thái
              },
            ),
            ListTile(
              title: Text(cauHoi.luaChon[3]),
              tileColor: model.c4,
              onTap: () {
                model.xuLyTraLoi(4,danhSachCauHoi[model.cauHienTai]);
                setState(() {}); // Cập nhật trạng thái
              },
            ),
            Visibility(
              visible: model.isChoose, // Nút sẽ hiển thị khi daChonCauHoi là true
              child: ElevatedButton(
                onPressed : () {
                  model.chuyenCauHoi();// Hàm này sẽ chuyển sang câu hỏi tiếp theo
                  setState(() {

                  });
                },
                child: Text('Câu tiếp theo'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
