import 'package:flutter/material.dart';
import 'package:second_app/model/question.dart';


class QuizModel {
  int diemSo = 0;
  int cauHienTai = 0;
  bool isChoose = false;
  Color c1 = Colors.white;
  Color c2 = Colors.white;
  Color c3 = Colors.white;
  Color c4 = Colors.white;
  Color color_diem = Colors.yellowAccent;
  double font_size = 20;


  void chuyenCauHoi() {

      color_diem = Colors.yellowAccent;
      font_size = 20;
      isChoose = false;
      cauHienTai++;
      resetColors();

  }

  void xuLyTraLoi(int luaChon,Question question) {
    if (!isChoose) {

      isChoose = true;
      int dapAn = question.dapAnDung;

      if (luaChon == dapAn) {
        color_diem = Colors.amber;
        font_size = 24;
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
    }
  }

  void resetColors() {
    c1 = Colors.white;
    c2 = Colors.white;
    c3 = Colors.white;
    c4 = Colors.white;
  }
}
