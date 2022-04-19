// ignore_for_file: camel_case_types, unnecessary_new

class listpdam_respon {
  int sukses = 0;

  List datPdam = [];

  listpdam_respon({required this.sukses, required this.datPdam});

  factory listpdam_respon.fromJson(Map<String, dynamic> json) {
    return listpdam_respon(sukses: json['sukses'], datPdam: json['Data_BK']);
  }
}
