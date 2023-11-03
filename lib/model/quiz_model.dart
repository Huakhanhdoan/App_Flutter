import 'package:flutter/material.dart';
import 'package:second_app/model/question.dart';

class QuizModel {
  int diemSo = 0;
  int cauHienTai = 0;
  bool isChoose = false; // kiểm tra xem đã chọn đáp án chưa
  bool isCorrect = false; // check xem đáp án chọn đúng hay sai

  List<Color> color_answer = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  void chuyenCauHoi() {
    isCorrect = false;
    isChoose = false;
    cauHienTai++;
    resetColors();
  }

  void xuLyTraLoi(int luaChon, Question question) {
    if (!isChoose) {
      isChoose = true;
      int dapAn = question.dapAnDung;

      if (luaChon == dapAn) {
        isCorrect = true;
        diemSo++;
      } else {
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
