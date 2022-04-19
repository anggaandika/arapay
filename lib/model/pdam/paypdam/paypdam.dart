// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:arapay/utility/main.dart';

class Paypdam {
  String PayPdam_nya,
      TrxId = '',
      Jam = '',
      Tgl = '',
      Kd41 = '',
      KdAgen = '',
      UserId = '',
      Password = '',
      IdTerminal = '',
      KdAktivasi = '',
      kdProduk = '',
      Chanel = '',
      NoStruk = '',
      Saldo = '',
      NamaPdam = '',
      IdPel = '',
      nominal = '',
      Jmltrx = '',
      Info1 = '',
      Info2 = '',
      Info3 = '',
      Signature_id = '';

  Paypdam(
      {required this.PayPdam_nya,
      required this.TrxId,
      required this.Jam,
      required this.Tgl,
      required this.Kd41,
      required this.KdAgen,
      required this.UserId,
      required this.Password,
      required this.IdTerminal,
      required this.KdAktivasi,
      required this.kdProduk,
      required this.Chanel,
      required this.NoStruk,
      required this.Saldo,
      required this.NamaPdam,
      required this.IdPel,
      required this.nominal,
      required this.Jmltrx,
      required this.Info1,
      required this.Info2,
      required this.Info3,
      required this.Signature_id});

  factory Paypdam.fromJson(Map<String, dynamic> json) {
    return Paypdam(
        PayPdam_nya: json['PayPdam'],
        TrxId: json['TrxId'],
        Jam: json['Jam'],
        Tgl: json['Tgl'],
        Kd41: json['Kd41'],
        KdAgen: json['KdAgen'],
        UserId: json['UserId'],
        Password: json['Password'],
        IdTerminal: json['IdTerminal'],
        KdAktivasi: json['kdAktivasi'],
        kdProduk: json['kdProduk'],
        Chanel: json['Chanel'],
        NoStruk: json['NoStruk'],
        Saldo: json['Saldo'],
        NamaPdam: json['NamaPdam'],
        IdPel: json['IdPel'],
        nominal: json['nominal'],
        Jmltrx: json['Jmltrx'],
        Info1: json['Info1'],
        Info2: json['Info2'],
        Info3: json['Info3'],
        Signature_id: json['Signature_id']);
  }
}

// login (POST)
Future<Response?> PayPdamConnect(Paypdam payPdam) async {
  String route = AppConfig.API_ENDPOINT + "/paypdam_ara2";
  try {
    final response = await http.post(Uri.parse(route),
        headers: {
          "Accept": "application/json",
          "Authorization": "123456789222222",
          "Content-Type": "application/json",
          "Origin": "arainfraindo.com"
        },
        body: jsonEncode({
          'PayPdam': payPdam.PayPdam_nya,
          'TrxId': payPdam.TrxId,
          'Jam': payPdam.Jam,
          'Tgl': payPdam.Tgl,
          'Kd41': payPdam.Kd41,
          'KdAgen': payPdam.KdAgen,
          'UserId': payPdam.UserId,
          'Password': payPdam.Password,
          'KdAktivasi': payPdam.KdAktivasi,
          'IdTerminal': payPdam.IdTerminal,
          'kdProduk': payPdam.kdProduk,
          'Chanel': payPdam.Chanel,
          'NoStruk': payPdam.NoStruk,
          'Saldo': payPdam.Saldo,
          'NamaPdam': payPdam.NamaPdam,
          'IdPel': payPdam.IdPel,
          'nominal': payPdam.nominal,
          'Jmltrx': payPdam.Jmltrx,
          'Info1': payPdam.Info1,
          'Info2': payPdam.Info2,
          'Info3': payPdam.Info3,
          'Signature_id': payPdam.Signature_id
        }));

    print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}
