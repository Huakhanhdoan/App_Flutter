import 'package:flutter/material.dart';
import 'package:second_app/model/question.dart';
import 'package:second_app/model/quiz_model.dart';
import 'package:second_app/screens/result.dart';

class HoiDapPage extends StatefulWidget {
  @override
  _HoiDapPageState createState() => _HoiDapPageState();
}

class _HoiDapPageState extends State<HoiDapPage> {
  final QuizModel model = QuizModel();
  List<Question> danhSachCauHoi = [];
  double progress=0;

  void docCauHoi() async {
    danhSachCauHoi = await Question.docTuJson('./assets/JSON/list_question.json');
    print('Số lượng câu hỏi: ${danhSachCauHoi.length}');
    setState(() {});
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
    if (model.cauHienTai == danhSachCauHoi.length) {
      return ResultPage(model.diemSo, danhSachCauHoi.length);
    }
    progress = (model.cauHienTai.toDouble())/danhSachCauHoi.length.toDouble();
    Question cauHoi = danhSachCauHoi[model.cauHienTai];

    return Scaffold(
        backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(''),
        actions: <Widget>[
          Center(
            child:  Container(
              width: 100,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black, width: 2), // Đặt viền màu xanh
              ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18), // Đặt góc bo tròn cho LinearProgressIndicator
          child: LinearProgressIndicator(
            value: progress,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.tealAccent),
            backgroundColor: Colors.white70,
          ),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
              child: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.lightBlue, // Đặt màu nền
                  borderRadius: BorderRadius.circular(40), // Đặt góc bo tròn
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    style: TextStyle(
                      fontSize: !model.isCorrect ? 20 : 24, // Kích thước chữ tăng lên khi chọn đúng
                      color: !model.isCorrect ? Colors.white : Colors.white, // Màu sắc chữ thay đổi khi chọn đúng
                      fontWeight: FontWeight.bold, // Làm đậm chữ
                    ),
                    duration: const Duration(milliseconds: 200), // Thời gian của hiệu ứng
                    child: Text('Điểm: ${model.diemSo}'),
                  ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Câu hỏi ${model.cauHienTai + 1}: ${cauHoi.cauHoi}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350.0,
                  height: 150.0,
                  child: Image.asset(cauHoi.hinhAnh),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Chia thành 2 cột
                    crossAxisSpacing: 10.0, // Khoảng cách giữa các cột
                    mainAxisSpacing: 10.0, // Khoảng cách giữa các hàng
                      childAspectRatio: 2.0,
                  ),
                  shrinkWrap: true, // Sử dụng shrinkWrap để giới hạn kích thước dọc
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(cauHoi.luaChon[i]),
                      tileColor: model.color_answer[i],
                      onTap: () {
                        model.xuLyTraLoi(i + 1, danhSachCauHoi[model.cauHienTai]);
                        setState(() {});
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: model.isChoose,
            child: ElevatedButton(
              onPressed: () {
                model.chuyenCauHoi();
                setState(() {});
              },
              child: Text('Câu tiếp theo'),
            ),
          ),
        ],
      ),
    );
  }
}
