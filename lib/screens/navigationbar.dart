import 'package:flutter/material.dart';
import 'package:second_app/screens/profile.dart';

import '../model/audio.dart';
import 'home_page.dart';

class NavigationBar1 extends StatefulWidget {
  @override
  _NavigationBar1State createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  AudioManager _audioManager = new AudioManager();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        IconButton(
          icon: const Icon(Icons.leaderboard), // Biểu tượng sẽ thừa kế các giá trị từ IconButtonTheme
          onPressed: () {
            _audioManager.playSound("click");
            // Xử lý khi bấm vào biểu tượng
          },
        ),


        IconButton(
          icon: Icon(Icons.person),
          onPressed: ()  {
            _audioManager.playSound("click");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        IconButton(

          icon: const Icon(Icons.home),
          onPressed: () {
            _audioManager.playSound("click");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            // Xử lý khi bấm vào icon trợ giúp
          },
        ),



        IconButton(
          icon: const Icon(Icons.volume_mute),
          onPressed: () {
            _audioManager.playSound("click");
            // Xử lý khi bấm vào icon trợ giúp
          },
        ),
        IconButton(

          icon: const Icon(Icons.settings),
          onPressed: () {
            _audioManager.playSound("click");
            // Xử lý khi bấm vào icon cài đặt
          },
        ),
      ],
    );
  }
}
