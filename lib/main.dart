import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:second_app/screens/home_page.dart';
import 'package:second_app/screens/loading.dart';
import 'package:second_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
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
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(10.0),
          ),
        ),
      ),
      home: SplashScreen(hasUserData: hasUserData),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final bool hasUserData;

  const SplashScreen({Key? key, required this.hasUserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulate loading time
    Timer(
      Duration(seconds: 2),
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => hasUserData ? HomePage() : Register(),
          ),
        );
      },
    );

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiệu ứng loading
            SpinKitWave(
              color: Colors.blue, // Màu sắc của hiệu ứng
              size: 50.0, // Kích thước của hiệu ứng
            ),
            SizedBox(height: 20.0),
            Text(
              'Đang tải...',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
