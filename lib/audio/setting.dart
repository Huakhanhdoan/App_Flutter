import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

import '../screens/navigationbar.dart';
import 'audio.dart';

class SoundSetting extends StatefulWidget {
  @override
  _SoundSettingState createState() => _SoundSettingState();
}

class _SoundSettingState extends State<SoundSetting> {
  double _volume = 0;

  // Thêm biến để lưu giữ âm lượng nhạc nền

  @override
  void initState() {
    super.initState();
    _initVolume();
  }

  _initVolume() async {
    _volume = await VolumeController().getVolume();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Cài đặt'),
      ),
      body: Container(
        color: Colors.green.shade50,
        child: Column(
          children: <Widget>[
             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // Đặt bán kính cong cho góc
                  color: Colors.orange.shade200, // Đặt màu nền
                ),
                child: ListTile(
                  title: const Text(
                    'Âm lượng hệ thống',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                       // Khoảng cách giữa Icon và Slider
                         const Icon(
                          Icons.volume_up,
                          size: 30.0, // Kích thước của Icon
                          color: Colors.black87, // Màu sắc của Icon

                      ),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          onChanged: (newVolume) {
                            setState(() {
                              _volume = newVolume;
                              VolumeController().setVolume(newVolume);
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // Đặt bán kính cong cho góc
                  color: Colors.orange.shade200, // Đặt màu nền
                ),
                child: ListTile(
                  title: const Text(
                    'Tắt âm',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Switch(
                    value: _volume == 0,
                    onChanged: (value) {
                      setState(() {
                        _volume = value ? 0 : 0.5;
                        VolumeController().setVolume(_volume);
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // Đặt bán kính cong cho góc
                  color: Colors.orange.shade200, // Đặt màu nền
                ),
                child: ListTile(
                  title: const Text(
                    'Tắt nhạc nền',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Switch(
                    value: AudioManager.isTrack == false,
                    onChanged: (value) {
                      setState(() {
                        AudioManager.isTrack = value ? false : true;
                      });
                    },
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/setting.gif",
                height: MediaQuery.of(context).size.height * 0.3,
              // height: 100.0,
              // width: 100.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar1(),
    );
  }
}
