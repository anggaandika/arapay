// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:arapay/utility/main.dart';

class Service {
  Future post(String url, {required body, encoding}) async {
    var _response = await http.post(
      Uri.parse(AppConfig.API_ENDPOINT + url),
      body: body,
      headers: {
        "Accept": "application/json",
        "Authorization": "123456789222222",
        "Content-Type": "application/json",
        "Origin": "arainfraindo.com"
      },
    );

    if (_response.statusCode != 200) {
      print('data filed');
      return null;
    }

    if (_response.body.isEmpty) {
      print('data kosong');
      return null;
    }
    var jsonResp = json.decode(_response.body);

    return jsonResp['Data_BK'];
  }

  Future post2(String url, {required body, encoding}) async {
    var _response = await http.post(
      Uri.parse(AppConfig.API_ENDPOINT + url),
      body: jsonDecode(body),
      headers: {
        "Accept": "application/json",
        "Authorization": "123456789222222",
        "Content-Type": "application/json",
        "Origin": "arainfraindo.com"
      },
    );

    if (_response.statusCode != 200) {
      print('data filed');
      return null;
    }

    if (_response.body.isEmpty) {
      print("error : ${_response.body}");
      return null;
    }
    var jsonResp = json.decode(_response.body);
    return jsonResp;
  }
}
