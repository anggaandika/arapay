// ignore_for_file: unused_field

import 'dart:convert';

import 'package:arapay/service/main.dart';
import 'package:arapay/utility/main.dart';

class Connecting {
  Future<dynamic> mloCodePos(List val) async {
    try {
      final data = await Service().post2("/nipos/getposcode",
          body: jsonEncode({
            "bacasetsapikey": "123456",
            "pasword": prefPas().then((value) => value).toString(),
            "kodeagen": prefCkdAgen().then((value) => value).toString(),
            "userLogin": prefCuserId().then((value) => value).toString(),
            "deviceid": prefIdTerminal().then((value) => value).toString(),
            "city": "Jakarta",
            "address": "",
            "location_id": "60d3efc0be8a1f0b9566ffe2",
          }));
      val = data['rs_postcode']['r_postcode'];
      return val;
    } catch (e) {
      return '';
    }
  }
}
