import 'package:flutter/material.dart';
import 'package:second_app/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int step = 1;
  String userName = "";
  int userAge = 18;
  String userGender = "";

  @override
  void initState() {
    super.initState();
    // Load giá trị từ SharedPreferences khi ứng dụng khởi động
    loadValues();
  }

  void loadValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? "";
      userAge = prefs.getInt('userAge') ?? 18;
      userGender = prefs.getString('userGender') ?? "";
    });
  }

  void saveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    prefs.setInt('userAge', userAge);
    prefs.setString('userGender', userGender);
  }

  void goBack() {
    if (step > 1) {
      setState(() {
        step--;
      });
    }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100), // Khoảng cách từ đỉnh màn hình đến dòng 'Bước $step /3'
            Text(
              'Bước $step /3',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: buildBody(),
            ),
          ],
        ),
      ),
    );
  }



  Widget buildBody() {
    switch (step) {
      case 1:
        return buildNameInput();
      case 2:
        return buildAgeSelector();
      case 3:
        return buildGenderSelection();
      default:
        return const Center(
          child: Text('Step không hợp lệ'),
        );
    }
  }

  Widget buildNameInput() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tên của bạn là?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              style: const TextStyle(color: Colors.white,fontSize: 24),
              decoration: const InputDecoration(labelText: 'Nhập tên'),
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),
          ),
          ElevatedButton.icon(
            icon:  const Icon(Icons.arrow_forward),
            onPressed: () {
              saveValues();
              setState(() {
                step = 2;
              });
            },
            label: const Text('Tiếp tục'),
          ),
        ],
      ),
    );
  }

  Widget buildAgeSelector() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20, 10.0, 50.0),
          child: Text(
            'Bạn bao nhiêu tuổi?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 70),
        Center(
          child: Text(
            'Tuổi của bạn: $userAge',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Slider(
          value: userAge.toDouble(),
          min: 10,
          max: 80,
          divisions: 70, // Số bước giữa min và max
          onChanged: (value) {
            saveValues();
            setState(() {
              userAge = value.round();
            });
          },
        ),
        ElevatedButton.icon(
          icon:  const Icon(Icons.arrow_forward),
          onPressed: () {
            saveValues();
            setState(() {
              step = 3;
            });
          },
          label: const Text('Tiếp tục'),
        ),
        const SizedBox(height: 50),
          ElevatedButton.icon(

            onPressed: () {
              saveValues();
              goBack(); // Chuyển về bước trước đó
            },
            icon:  const Icon(Icons.arrow_back),
            label:const Text('Quay lại') ,

          ),

      ],
    );
  }

  Widget buildGenderSelection() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Chọn giới tính',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon:  const Icon(Icons.male),
                onPressed: () {
                  saveValues();
                  setState(() {
                    userGender = userGender == "Nam" ? "" : "Nam";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: userGender == "Nam" ? Colors.green : null,

                ),
                label: const Text('Nam'),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon:  const Icon(Icons.female),
                onPressed: () {
                  saveValues();
                  setState(() {
                    userGender = userGender == "Nữ" ? "" : "Nữ";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: userGender == "Nữ" ? Colors.green : null,

                ),
                label: const Text('Nữ'),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon:  const Icon(Icons.devices_other),
                onPressed: () {
                  saveValues();
                  setState(() {
                    userGender = userGender == "Khác" ? "" : "Khác";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: userGender == "Khác" ? Colors.green : null,

                ),
                label: const Text('Khác'),
              ),
            ],
          ),

          const SizedBox(height: 40),

            ElevatedButton.icon(
              icon:  const Icon(Icons.confirmation_num),
              onPressed: () {
                saveValues();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
                // Các giá trị đã được lưu vào SharedPreferences
                // Ở đây bạn có thể thực hiện các xử lý khác nếu cần
              },
              label: const Text(
                'Hoàn thành',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),



          const SizedBox(height: 60),

             ElevatedButton.icon(

              onPressed: () {
                saveValues();
                goBack(); // Chuyển về bước trước đó
              },
              icon:  const Icon(Icons.arrow_back),
              label:const Text('Quay lại') ,

            ),

        ],

    );
  }
}
