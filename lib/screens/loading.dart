
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.jpg'), // Đường dẫn đến hình ảnh nền
              fit: BoxFit.cover,
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitWave(
                color: Colors.blue,
                size: 50.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Đang tải...',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );

  }
}


