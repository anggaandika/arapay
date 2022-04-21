// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:arapay/utility/main.dart';

class User {
  final String trxId,
      jam,
      tgl,
      userId,
      password,
      idTerminal,
      kdAktivasi,
      versi,
      signatureid;

  User(
      {required this.trxId,
      required this.jam,
      required this.tgl,
      required this.userId,
      required this.password,
      required this.idTerminal,
      required this.kdAktivasi,
      required this.versi,
      required this.signatureid});
  // User({required this.idUser, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        trxId: json['TrxId'],
        jam: json['Jam'],
        tgl: json['Tgl'],
        userId: json['UserId'],
        password: json['Password'],
        idTerminal: json['IdTerminal'],
        kdAktivasi: json['KdAktivasi'],
        versi: json['Versi'],
        signatureid: json['Signature_id']);
  }
}

// login (POST)
Future<Response?> login(User user) async {
  String route = AppConfig.API_ENDPOINT + "/login_ara2";
  try {
    final response = await http.post(Uri.parse(route),
        headers: {
          "Accept": "application/json",
          "Authorization": "123456789222222",
          "Content-Type": "application/json",
          "Origin": "arainfraindo.com"
        },
        body: jsonEncode({
          'TrxId': user.trxId,
          'Jam': user.jam,
          'Tgl': user.tgl,
          'UserId': user.userId,
          'Password': user.password,
          'IdTerminal': user.idTerminal,
          'KdAktivasi': user.kdAktivasi,
          'Versi': user.versi,
          'Signature_id': user.signatureid
        }));

    // print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}
