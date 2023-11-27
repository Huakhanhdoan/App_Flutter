import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/user.dart';
import 'navigationbar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String avatarPath = "";

  @override
  void initState() {
    super.initState();
    _loadAvatarPath();
  }

  Future<void> _loadAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarPath = prefs.getString('avatarPath') ?? "";
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (pickedFile != null) {
      setState(() {
        avatarPath = pickedFile.path;
        prefs.setString('avatarPath', avatarPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Trang cá nhân'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserInfoFromPrefs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> userInfo = snapshot.data!;
              return ListView(
                children: [
                   const SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(360),
                            border: Border.all(
                              color: Colors.orange,
                              width: 5.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: (avatarPath.isEmpty|| avatarPath == "")
                                ? const AssetImage(
                                    'assets/images/user.png') // Ảnh mặc định nếu không có avatar
                                : Image.file(File(avatarPath))
                                    .image, // Hiển thị ảnh từ đường dẫn đã lưu
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: _pickImage,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 16.0),
                      Text(
                        userInfo['userName'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.people,color: Colors.white,),
                          Text(
                            ' Giới Tính: ${userInfo['userGender']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Tuổi: ${userInfo['userAge']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sports_score,color: Colors.white,),
                          Text(
                            'Điểm Số: ${userInfo['sum_score']}',
                            style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        "Thành tích: ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white38, // Màu đen
                            width: 5.0, // Độ dày 2px
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gradient: RadialGradient(
                            colors: [
                              Colors.deepPurple.shade900,
                              Colors.indigo.shade900,
                            ],
                            stops: const [0.0, 1.0],
                            center: Alignment.center,
                            radius: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: !userInfo['trung']&&!userInfo['nam']&&!userInfo['bac'],
                                child:Text("Chưa có huy hiệu nào",
                                  style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white) ,)
                            ),
                            Visibility(
                                visible: userInfo['bac'],
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/huychuong1.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    const Text(
                                      "Bắc",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.greenAccent),
                                    )
                                  ],
                                )),
                            Visibility(
                                visible: userInfo['trung'],
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/huychuong2.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    const Text(
                                      "Trung",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.blue),
                                    )
                                  ],
                                )),
                            Visibility(
                                visible: userInfo['nam'],
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/huychuong3.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    const Text(
                                      "Nam",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.yellow),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          ).then((value) {
                            // Cập nhật lại trang profile sau khi chỉnh sửa
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Chỉnh Sửa'),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: NavigationBar1(),
    );
  }
}
