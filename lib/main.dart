import 'package:flutter/material.dart';
import 'package:second_app/screens/home_page.dart';
import 'package:second_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Tên: ${prefs.getString('name')}');
  print('Tuổi: ${prefs.getInt('age')}');
  // Kiểm tra xem đã nhập thông tin cá nhân chưa
  bool hasUserData = prefs.getBool('hasUserData') ?? false;

  runApp(MyApp(hasUserData: hasUserData));
}

class MyApp extends StatelessWidget {
  final bool hasUserData;

  const MyApp({Key? key, required this.hasUserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(10.0),
          ),
        ),
      ),
      home: hasUserData ? HomePage() : Register(),
    );
  }
}

