import 'package:flutter/material.dart';
import 'package:second_app/screens/profile.dart';

import 'home_page.dart';

class NavigationBar1 extends StatefulWidget {
  @override
  _NavigationBar1State createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: ()  {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            // Xử lý khi bấm vào icon trợ giúp
          },
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
    );
  }
}
