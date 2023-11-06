import 'package:flutter/material.dart';
import 'package:second_app/screens/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.orangeAccent, // Màu chính cho ứng dụng
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
            .copyWith(secondary: Colors.orange), // Màu phụ (sử dụng cho nút và các phần nhấn)
        fontFamily: 'Montserrat', // Font chữ mặc định
        textTheme:  const TextTheme(
          bodyLarge: TextStyle(fontSize: 16), // Font chữ cho văn bản thông thường
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Font chữ cho văn bản đậm
        ),
      ),

    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedLocation;
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Chủ'),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                // Xử lý khi bấm vào icon trợ giúp
              },
            ),
          ]
        ),

      body: Stack(
        children: [
          Image.asset(
            'assets/images/map.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          _buildLocationButton(125, 100, 'Bắc'),
          _buildLocationButton(180, 250, 'Trung'),
          _buildLocationButton(180, 380, 'Nam'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

              IconButton(
                icon: const Icon(Icons.leaderboard), // Biểu tượng sẽ thừa kế các giá trị từ IconButtonTheme
                onPressed: () {
                  // Xử lý khi bấm vào biểu tượng
                },
              ),


            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Xử lý khi bấm vào icon thông tin cá nhân
              },
            ),

            ElevatedButton(
              onPressed: (selectedLocation != null) ? () { startQuiz(); } : null,
              child: Text('Bắt đầu'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // Màu nền khi nút không hoạt động
                  }
                  return Colors.blue; // Màu nền khi nút hoạt động
                }),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Khoảng cách giữa nội dung và viền
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Độ cong của góc
                  ),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 20, // Kích thước chữ
                    fontWeight: FontWeight.bold, // Độ đậm của chữ
                  ),
                ),
                // Tạo bóng cho nút
                shadowColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // Màu bóng khi nút không hoạt động
                  }
                  return Colors.blue.shade200; // Màu bóng khi nút hoạt động
                }),
                elevation: MaterialStateProperty.all<double>(8.0), // Độ nâng của bóng
              ),
            ),



            IconButton(
              icon: const Icon(Icons.volume_mute),
              onPressed: () {
                // Xử lý khi bấm vào icon trợ giúp
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Xử lý khi bấm vào icon cài đặt
              },
            ),
          ],
        ),
      ),
    );
  }
  void startQuiz() {
    if (selectedLocation == null) {
      // Hiển thị thông báo khi không có địa điểm nào được chọn
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn một địa điểm trước khi bắt đầu.'),
        ),
      );
    } else {
      // Nếu đã chọn địa điểm, thì điều hướng đến trang câu hỏi
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HoiDapPage()));
    }
  }
  Widget _buildLocationButton(double left, double top, String location) {
    return Positioned(
      left: left,
      top: top,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(selectedLocation == location ? Colors.orange : Colors.amber[50]),
        ),
        onPressed: () {
          setState(() {
            selectedLocation = location;
          });
        },
        child: Text(location),
      ),
    );
  }
}

