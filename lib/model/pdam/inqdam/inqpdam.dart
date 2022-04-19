// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:arapay/utility/main.dart';

class Inqpdam {
  String Inqpdamnya,
      TrxId,
      Jamnya,
      Tglnya,
      KdAgen,
      UserId,
      Password,
      KdAktivasi,
      IdTerminal,
      Responkota,
      KdProduk = '',
      Chanel,
      NoStruk,
      NamaPdam,
      IdPel,
      Signature_id;
  int Saldo;
  Inqpdam(
      {required this.Inqpdamnya,
      required this.TrxId,
      required this.Jamnya,
      required this.Tglnya,
      required this.KdAgen,
      required this.UserId,
      required this.Password,
      required this.KdAktivasi,
      required this.IdTerminal,
      required this.Responkota,
      required this.KdProduk,
      required this.Chanel,
      required this.NoStruk,
      required this.Saldo,
      required this.NamaPdam,
      required this.IdPel,
      required this.Signature_id});

  factory Inqpdam.fromJson(Map<String, dynamic> json) {
    return Inqpdam(
        Inqpdamnya: json['Inqpdamnya'],
        TrxId: json['TrxId'],
        Jamnya: json['jamnya'],
        Tglnya: json['tglnya'],
        KdAgen: json['KdAgen'],
        UserId: json['UserId'],
        Password: json['Password'],
        KdAktivasi: json['kdAktivasi'],
        IdTerminal: json['IdTerminal'],
        Responkota: json['responkota'],
        KdProduk: json['kdProduk'],
        Chanel: json['Chanel'],
        NoStruk: json['NoStruk'],
        Saldo: json['Saldo'],
        NamaPdam: json['NamaPdam'],
        IdPel: json['IdPel'],
        Signature_id: json['Signature_id']);
  }
}

// login (POST)
Future<Response?> InqPdamCon(Inqpdam inqpdam) async {
  String route = AppConfig.API_ENDPOINT + "/inqpdam_ara2";
  try {
    final response = await http.post(Uri.parse(route),
        headers: {
          "Accept": "application/json",
          "Authorization": "123456789222222",
          "Content-Type": "application/json",
          "Origin": "arainfraindo.com"
        },
        body: jsonEncode({
          'InqPdam': inqpdam.Inqpdamnya,
          'TrxId': inqpdam.TrxId,
          'Jam': inqpdam.Jamnya,
          'Tgl': inqpdam.Tglnya,
          'KdAgen': inqpdam.KdAgen,
          'UserId': inqpdam.UserId,
          'Password': inqpdam.Password,
          'KdAktivasi': inqpdam.KdAktivasi,
          'IdTerminal': inqpdam.IdTerminal,
          'kdProduk': inqpdam.KdProduk,
          'Chanel': inqpdam.Chanel,
          'NoStruk': inqpdam.NoStruk,
          'Saldo': inqpdam.Saldo,
          'NamaPdam': inqpdam.NamaPdam,
          'IdPel': inqpdam.IdPel,
          'Signature_id': inqpdam.Signature_id
        }));

    print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}
