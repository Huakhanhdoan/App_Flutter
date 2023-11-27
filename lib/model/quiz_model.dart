
import 'package:flutter/material.dart';
import 'package:second_app/audio/audio.dart';
import 'package:second_app/repository/question.dart';

class QuizModel {
  AudioManager _audioManager = new AudioManager();
  String location ="";
  int diemSo = 0;
  int count =0;
  int cauHienTai = 0;
  bool isChoose = false; // kiểm tra xem đã chọn đáp án chưa
  bool isCorrect = false; // check xem đáp án chọn đúng hay sai
QuizModel(this.location) {
  if(location == "Trung") {
    cauHienTai = 10;
  }
  if(location=="Nam") {
    cauHienTai=20;
  }
}
  List<Color> color_answer = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  void chuyenCauHoi() {
    isCorrect = false;
    isChoose = false;
    count++;
    cauHienTai++;
    resetColors();
    _audioManager.stop();
  }

  void xuLyTraLoi(int luaChon, Question question) {
    if (!isChoose) {
      isChoose = true;
      int dapAn = question.dapAnDung;

      if (luaChon == dapAn) {
        _audioManager.playSound('success');
        isCorrect = true;
        diemSo++;
      } else {
        _audioManager.playSound('wrong');
        isCorrect = false;
        switch (luaChon) {
          case 1:
            color_answer[0] = Colors.red;
            break;
          case 2:
            color_answer[1] = Colors.red;
            break;
          case 3:
            color_answer[2] = Colors.red;
            break;
          case 4:
            color_answer[3] = Colors.red;
            break;
        }
      }
      switch (dapAn) {
        case 1:
          color_answer[0] = Colors.green;
          break;
        case 2:
          color_answer[1] = Colors.green;
          break;
        case 3:
          color_answer[2] = Colors.green;
          break;
        case 4:
          color_answer[3] = Colors.green;
          break;
      }
    }
  }

  void resetColors() {
    for (int i = 0; i < 4; i++) {
      color_answer[i] = Colors.white;
    }
  }
}
