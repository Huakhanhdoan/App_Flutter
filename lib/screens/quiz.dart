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
  double progress = 0;

  void docCauHoi() async {
    danhSachCauHoi =
        await Question.docTuJson('./assets/JSON/list_question.json');
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
    progress = (model.cauHienTai.toDouble()) / danhSachCauHoi.length.toDouble();
    Question cauHoi = danhSachCauHoi[model.cauHienTai];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            color: Colors.yellow.shade100,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.run_circle_sharp,color: Colors.teal,),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: LinearProgressIndicator(
                      value: progress,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.tealAccent),
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        style: TextStyle(
                          fontSize: !model.isCorrect ? 20 : 24,
                          color: !model.isCorrect ? Colors.white : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        duration: const Duration(milliseconds: 200),
                        child: Text('Điểm: ${model.diemSo}'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.shade200,
                    Colors.blue.shade200,
                  ],
                  stops: const [0.0, 1.0],
                  center: Alignment.center,
                  radius: 1.0,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Câu hỏi ${model.cauHienTai + 1}: ${cauHoi.cauHoi}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          width: 350.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(cauHoi.hinhAnh),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // child: Image.asset(cauHoi.hinhAnh),
                        ),
                        const SizedBox(height: 25),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.0,
                          ),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, i) {
                            return Container(
                              color: model.color_answer[i],
                              margin: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(cauHoi.luaChon[i]),
                                onTap: () {
                                  model.xuLyTraLoi(
                                      i + 1, danhSachCauHoi[model.cauHienTai]);
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: model.isChoose,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        model.chuyenCauHoi();
                        setState(() {});
                      },
                      icon: const Icon(Icons.skip_next),
                      label: const Text('Câu tiếp theo'),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
