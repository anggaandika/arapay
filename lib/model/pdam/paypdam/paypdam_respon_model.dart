// ignore_for_file: non_constant_identifier_names, camel_case_types, duplicate_ignore

import 'dart:core';

class paypdamresponmodel {
  // ignore: non_constant_identifier_names
  String TrxId,
      Chanel = '',
      bit39 = '',
      Jmltrx = '',
      IdTerminal = '',
      kdProduk = '',
      KdAktivasi = '',
      IdPel = '',
      NamaPdam = '',
      KdAgen = '',
      nominal = '',
      Kd41 = '',
      UserId = '',
      Saldo = '',
      Jam = '',
      Tgl = '',
      Info1 = '',
      Info2 = '',
      Info3 = '',
      NoStruk = '',
      Password = '';

  paypdamresponmodel(
      {required this.TrxId,
      required this.Chanel,
      required this.bit39,
      required this.Jmltrx,
      required this.IdTerminal,
      required this.kdProduk,
      required this.KdAktivasi,
      required this.IdPel,
      required this.NamaPdam,
      required this.KdAgen,
      required this.nominal,
      required this.Kd41,
      required this.UserId,
      required this.Saldo,
      required this.Jam,
      required this.Tgl,
      required this.Info1,
      required this.Info2,
      required this.Info3,
      required this.NoStruk,
      required this.Password});

  @override
  String toString() {
    return 'paypdamresponmodel{TrxId: $TrxId, Chanel: $Chanel, bit39: $bit39, Jmltrx: $Jmltrx, IdTerminal: $IdTerminal, kdProduk: $kdProduk, KdAktivasi: $KdAktivasi, IdPel: $IdPel, NamaPdam: $NamaPdam, KdAgen: $KdAgen, nominal: $nominal, Kd41: $Kd41, UserId: $UserId, Saldo: $Saldo, Jam: $Jam, Tgl: $Tgl, Info1: $Info1, Info2: $Info2, NoStruk: $NoStruk, Password: $Password}';
  }

  factory paypdamresponmodel.fromJson(Map<String, dynamic> json) {
    return paypdamresponmodel(
        TrxId: json["TrxId"],
        Chanel: json["Chanel"],
        bit39: json["bit39"],
        Jmltrx: json["Jmltrx"] ?? '',
        IdTerminal: json["IdTerminal"],
        kdProduk: json["kdProduk"],
        KdAktivasi: json["KdAktivasi"],
        IdPel: json["IdPel"],
        NamaPdam: json["NamaPdam"],
        KdAgen: json["KdAgen"],
        nominal: json["nominal"],
        Kd41: json["Kd41"],
        UserId: json["UserId"],
        Saldo: json["Saldo"],
        Jam: json["Jam"],
        Tgl: json["Tgl"],
        Info1: json["Info1"],
        Info2: json["Info2"],
        Info3: json["Info3"],
        NoStruk: json["NoStruk"],
        Password: json["Password"]);
  }
}
