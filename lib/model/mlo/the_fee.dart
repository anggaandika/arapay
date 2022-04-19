import 'dart:convert';

import 'package:arapay/service/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> theCodePos() async {
  final prefs = await SharedPreferences.getInstance();
  String _id = prefs.getString("IdTerminal")!;
  String _user = prefs.getString("cuserid")!;
  String _pasword = prefs.getString("password")!;
  String _ckdagen = prefs.getString("ckdagen")!;
  try {
    final data = await Service().post2("/nipos/getposcode",
        body: jsonEncode({
          "bacasetsapikey": "123456",
          "pasword": _pasword,
          "kodeagen": _ckdagen,
          "userLogin": _user,
          "deviceid": _id,
          "city": "Jakarta",
          "address": "",
          "location_id": "60d3efc0be8a1f0b9566ffe2",
        }));
    return data['rs_postcode']['r_postcode'];
  } catch (e) {
    // ignore: avoid_print
    print("Error : ${e.toString()}");
    return '';
  }
}
