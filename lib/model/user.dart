import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getUserInfoFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userName = prefs.getString('userName') ?? "";
  int userAge = prefs.getInt('userAge') ?? 0;
  String userGender = prefs.getString('userGender') ?? "";

  return {
    'userName': userName,
    'userAge': userAge,
    'userGender': userGender,
  };
}
