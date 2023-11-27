import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, dynamic>> getUserInfoFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userName = prefs.getString('userName') ?? "";
  int userAge = prefs.getInt('userAge') ?? 0;
  String userGender = prefs.getString('userGender') ?? "";
  int sum_score = prefs.getInt('sum_score') ?? 0;
  bool mendal_bac = prefs.getBool('bac') ?? false;
  bool mendal_trung = prefs.getBool('trung') ?? false;
  bool mendal_nam = prefs.getBool('nam') ?? false;

  return {
    'userName': userName,
    'userAge': userAge,
    'userGender': userGender,
    'sum_score': sum_score,
    'bac': mendal_bac,
    'trung': mendal_trung,
    'nam': mendal_nam,
  };
}

