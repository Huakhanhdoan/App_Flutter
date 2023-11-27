import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Question {
  final String cauHoi;
  final List<String> luaChon;
  final int dapAnDung;
  final String hinhAnh;

  Question({required this.cauHoi, required this.luaChon, required this.dapAnDung, required this.hinhAnh});

  static Future<List<Question>> docTuJson(String duongDan) async {
    final data = await rootBundle.loadString(duongDan);
    final jsonResult = jsonDecode(data);

    return jsonResult.map<Question>((item) {
      return Question(
        cauHoi: item['cauHoi'],
        luaChon: List<String>.from(item['luaChon']),
        dapAnDung: item['dapAnDung'],
        hinhAnh: item['hinhAnh'],
      );
    }).toList();
  }

}

