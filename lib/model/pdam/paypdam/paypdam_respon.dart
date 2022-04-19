// ignore_for_file: unused_import, camel_case_types
import 'paypdam_respon_model.dart';

class paypdam_respon {
  String success;
  paypdamresponmodel respaypdam;

  paypdam_respon({required this.success, required this.respaypdam});

  factory paypdam_respon.fromJson(Map<String, dynamic> json) {
    return paypdam_respon(
        success: json['success'],
        respaypdam: paypdamresponmodel.fromJson(json['respaypdam']));
  }
}

List<paypdam_respon> responPaydamFromJson(jsonData) {
  List<paypdam_respon> result = List<paypdam_respon>.from(
      jsonData.map((item) => paypdam_respon.fromJson(item)));

  return result;
}
