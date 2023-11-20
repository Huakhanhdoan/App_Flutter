import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigationbar.dart';

class ProfilePage extends StatelessWidget {
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
      body: Container(
        decoration: const BoxDecoration(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(
                            'assets/images/user.png'), // Đường dẫn avatar
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
                      Text(
                        'Giới Tính: ${userInfo['userGender']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                   Center(
                    child: Text(
                      'Điểm Số: ${userInfo['sum_score']}',

                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
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
