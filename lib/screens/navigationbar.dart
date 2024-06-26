import 'package:flutter/material.dart';
import 'package:second_app/screens/profile.dart';

import '../audio/audio.dart';
import '../audio/setting.dart';
import 'home_page.dart';


class NavigationBar1 extends StatefulWidget {
  @override
  _NavigationBar1State createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  final AudioManager _audioManager = new AudioManager();
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [



          IconButton(
            icon: Icon(Icons.menu, ),
            onPressed: ()  {
              _audioManager.playSound("click");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),

            IconButton(

              icon:  const Icon(Icons.home,size: 30),
              onPressed: () {
                _audioManager.playSound("click");
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                // Xử lý khi bấm vào icon trợ giúp
              },
            ),





          IconButton(

            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoundSetting()));
              _audioManager.playSound("click");
              // Xử lý khi bấm vào icon cài đặt
            },
          ),
        ],
      );




  }
}
