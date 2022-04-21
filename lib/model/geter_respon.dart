class GetRespon {
  String success;
  Map<String, dynamic> respon;

  GetRespon({required this.success, required this.respon});

  factory GetRespon.fromJson(Map<String, dynamic> json) {
    return GetRespon(success: json.values.first, respon: json.values.last);
  }
}
