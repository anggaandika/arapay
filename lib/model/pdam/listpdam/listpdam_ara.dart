// ignore_for_file: avoid_print

import 'dart:convert';

// import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:arapay/utility/main.dart';

// String passwordmd5 = new String("123");
// String password = SimpleMD5.MD5(passwordmd5);

// String bacasetsapikey = "123456";
// String pasword = password;

// String lwilayah = "JATIM";
// String kodeagen = "1001";
// String userLogin = "bembi3";
// String deviceid = "-1237982591";

class ListPdam {
  final String bacasetsapikey, pasword, lwilayah, kodeagen, userLogin, deviceid;

  ListPdam(
      {required this.bacasetsapikey,
      required this.pasword,
      required this.lwilayah,
      required this.kodeagen,
      required this.userLogin,
      required this.deviceid});
  // User({this.idUser, this.username, this.password});

  factory ListPdam.fromJson(Map<String, dynamic> json) {
    return ListPdam(
        bacasetsapikey: json['bacasetsapikey'],
        pasword: json['pasword'],
        lwilayah: json['lwilayah'],
        kodeagen: json['kodeagen'],
        userLogin: json['userLogin'],
        deviceid: json['deviceid']);
  }
}

// listpdam (POST)
Future<Response?> listPdam(ListPdam listPdam) async {
  String route = AppConfig.API_ENDPOINT + "/report/getlistpdam";
  try {
    final response = await http.post(Uri.parse(route),
        headers: {
          "Accept": "application/json",
          "Authorization": "123456789222222",
          "Content-Type": "application/json",
          "Origin": "arainfraindo.com"
        },
        body: jsonEncode({
          'bacasetsapikey': listPdam.bacasetsapikey,
          'pasword': listPdam.pasword,
          'lwilayah': listPdam.lwilayah,
          'kodeagen': listPdam.kodeagen,
          'userLogin': listPdam.userLogin,
          'deviceid': listPdam.deviceid
        }));

    print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}
