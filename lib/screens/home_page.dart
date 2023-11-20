
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_app/screens/profile.dart';
import 'package:second_app/screens/quiz.dart';



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
        backgroundColor: Colors.orangeAccent,
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
          _buildLocationButton(0.35, 0.15, 'Bắc'),
          _buildLocationButton(0.55, 0.4, 'Trung'),
          _buildLocationButton(0.45, 0.6, 'Nam'),
          _buildMessageCard()
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
              icon: const Icon(Icons.person),
              onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),

            ElevatedButton(
              onPressed: (selectedLocation != null) ? () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HoiDapPage()));; } : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // Màu nền khi nút không hoạt động
                  }
                  return Colors.blue; // Màu nền khi nút hoạt động
                }),

                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontFamily: 'Press Start 2P',
                    fontSize: 20, // Kích thước chữ
                    fontWeight: FontWeight.bold, // Độ đậm của chữ
                  ),
                ),

              ),
              child: Text('Khám phá'),

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

  Widget _buildLocationButton(double leftFactor, double topFactor, String location) {
    return Positioned(
      left: MediaQuery.of(context).size.width * leftFactor,
      top: MediaQuery.of(context).size.height * topFactor,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(selectedLocation == location ? Colors.green : Colors.amber[200]),
        ),
        onPressed: () {
          setState(() {
            selectedLocation = location;
          });
        },
        icon: const Icon(Icons.location_on),
        label: Text(location),
      ),
    );
  }
  Widget _buildMessageCard() {
    return Positioned(
        left: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.01,
        child: Visibility(
          visible: selectedLocation == null,
          child:  Row(
            children: [
              Image.asset(
                "assets/images/notification.gif",
                height: 100.0,
                width: 100.0,
              ),
              Card(
                elevation: 8.0, // Độ nâng của bóng
                color: Colors.yellow.shade200, // Màu nền của thẻ
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Hãy chọn một địa điểm!',
                    style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            ],
          ),

        ),
    );
  }

}

