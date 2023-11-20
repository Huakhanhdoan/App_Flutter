import 'dart:convert';
import 'dart:io';

class User {
  String name;
  String age;
  String gender;

  User({
    required this.name,
    required this.age,
    required this.gender,
  });

  // Hàm chuyển đổi đối tượng thành Map để lưu vào JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
    };
  }

  void saveUserInfoToFile() {
    final jsonUserInfo = toJson();
    final jsonString = json.encode(jsonUserInfo);

    // Đường dẫn đến tệp JSON (thay đổi đường dẫn tùy thuộc vào nơi bạn muốn lưu)
    const filePath = './user.json';

    // Lưu chuỗi JSON vào tệp
    File(filePath).writeAsStringSync(jsonString);
  }
}
