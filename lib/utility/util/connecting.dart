// ignore_for_file: unused_field

import 'dart:convert';

import 'package:arapay/service/main.dart';
import 'package:arapay/utility/part/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connecting {
  String? _deviceid;
  String? _userid;
  String? _pasword;
  String? _ckdagen;
  String? _cnostruk;
  int? _csaldo;
  void setMainData() async {
    final prefs = await SharedPreferences.getInstance();
    _deviceid = prefs.getString("IdTerminal")!;
    _userid = prefs.getString("cuserid")!;
    _pasword = prefs.getString("password")!;
    _ckdagen = prefs.getString("ckdagen")!;
    _cnostruk = prefs.getString("cnostruk")!;
    _csaldo = prefs.getInt("csaldo")!;
  }

  Future<dynamic> mloFee(context) async {
    try {
      final data = await Service().post2("/nipos/getposcode",
          body: jsonEncode({
            "bacasetsapikey": "123456",
            "pasword": _pasword,
            "kodeagen": _ckdagen,
            "userLogin": _userid,
            "deviceid": _deviceid,
            "city": "Jakarta",
            "address": "",
            "location_id": "60d3efc0be8a1f0b9566ffe2",
          }));
      return data['rs_postcode']['r_postcode'];
    } catch (e) {
      dialog(context, "Error : ${e.toString()}");
      return '';
    }
  }
}
