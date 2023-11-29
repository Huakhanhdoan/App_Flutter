
import 'package:flutter/material.dart';
import 'package:second_app/repository/question.dart';
import 'package:second_app/model/quiz_model.dart';
import 'package:second_app/screens/result.dart';

import '../audio/audio.dart';
import 'navigationbar.dart';

class HoiDapPage extends StatefulWidget {
   final String Location;
  HoiDapPage(this.Location);
  @override
  _HoiDapPageState createState() => _HoiDapPageState();
}

class _HoiDapPageState extends State<HoiDapPage> {
 String location = "";
 AudioManager _audioManager = new AudioManager();

 late final QuizModel model;
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
    _audioManager.playSound('sound_track');
    _audioManager.Loop();
    super.initState();
    location = widget.Location;
     model = QuizModel(location);
    docCauHoi();
  }

  @override
  Widget build(BuildContext context) {
    if (danhSachCauHoi.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (model.count==10) {
      _audioManager.stop();
      return ResultPage(model.diemSo,location);
    }
    progress = (model.cauHienTai.toDouble())%10 / 10.0;
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
                          fontSize: !model.isCorrect ? 20 : 22,
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
                          padding: const EdgeInsets.fromLTRB(20.0,0,0,0),
                          child: Text(
                            'Câu hỏi ${model.count+1}: ${cauHoi.cauHoi}',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 15),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.7,
                          ),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, i) {
                            return Container(
                              color: model.color_answer[i],
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: ListTile(
                                  title: Text(cauHoi.luaChon[i],style: TextStyle(fontWeight: FontWeight.bold),),
                                  onTap: () {
                                    model.xuLyTraLoi(
                                        i + 1, danhSachCauHoi[model.cauHienTai]);
                                    setState(() {});
                                  },
                                ),
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
                   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar1(),
    );
  }
}
