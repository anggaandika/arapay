// ignore_for_file: camel_case_types

import 'inqpdam_respon_model.dart';

class inqpdam_respon {
  String success;
  inqpdamresponmodel resinqpdam;

  inqpdam_respon({required this.success, required this.resinqpdam});

  factory inqpdam_respon.fromJson(Map<String, dynamic> json) {
    return inqpdam_respon(
        success: json['success'],
        resinqpdam: inqpdamresponmodel.fromJson(json['resinqpdam']));
  }
}

List<inqpdam_respon> responInqodamFromJson(jsonData) {
  List<inqpdam_respon> result = List<inqpdam_respon>.from(
      jsonData.map((item) => inqpdam_respon.fromJson(item)));

  return result;
}
