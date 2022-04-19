// ignore_for_file: camel_case_types, file_names

import 'Reslogin.dart';

class login_respon {
  String success;
  Reslogin reslogin;

  login_respon({required this.success, required this.reslogin});

  factory login_respon.fromJson(Map<String, dynamic> json) {
    return login_respon(
        success: json['success'],
        reslogin: Reslogin.fromJson(json['reslogin']));
  }
}

List<login_respon> responLoginFromJson(jsonData) {
  List<login_respon> result = List<login_respon>.from(
      jsonData.map((item) => login_respon.fromJson(item)));

  return result;
}
