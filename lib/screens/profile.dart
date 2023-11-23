import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (pickedFile != null) {
      setState(() {
        avatarPath = pickedFile.path;
        prefs.setString('avatarPath', avatarPath);
      });
    }
  }

  Future<Map<String, dynamic>> getUserInfoFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? "";
    int userAge = prefs.getInt('userAge') ?? 0;
    String userGender = prefs.getString('userGender') ?? "";
    int sum_score = prefs.getInt('sum_score') ?? 0;

    return {
      'userName': userName,
      'userAge': userAge,
      'userGender': userGender,
      'sum_score': sum_score,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Container(
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_res.jpg'),
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

                  const SizedBox(height: 50,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(

                        children:[  CircleAvatar(
                          radius: 50.0,
                          backgroundImage: avatarPath.isEmpty
                              ? const AssetImage('assets/images/user.png') // Ảnh mặc định nếu không có avatar
                              : Image.file(File(avatarPath)).image, // Hiển thị ảnh từ đường dẫn đã lưu
                        ),
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                              icon: Icon(Icons.edit,size: 30,color: Colors.white,),
                              onPressed: _pickImage,
                            ),
                          ),
            ]

                      ),

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

                      Text(
                        'Tuổi: ${userInfo['userAge']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),

                        Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const Icon(Icons.people),
                           Text(
                                ' Giới Tính: ${userInfo['userGender']}',
                                style:  const TextStyle(
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
                          const Icon(Icons.sports_score),
                          Text(
                            'Điểm Số: ${userInfo['sum_score']}',
                            style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
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
