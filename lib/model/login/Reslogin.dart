// ignore_for_file: non_constant_identifier_names, file_names, duplicate_ignore

import 'dart:core';

class Reslogin {
  // ignore: non_constant_identifier_names
  String Trxid,
      cjalurpln,
      // ignore: non_constant_identifier_names
      Bagian_tujuan,
      ckdagen,
      codeb2b,
      // ignore: non_constant_identifier_names
      Bagian_asal,
      cnama,
      userid,
      cversiapp,
      token = '',
      keymlo,
      clevel,
      ckota,
      csaldo,
      // ignore: non_constant_identifier_names
      Kode_produk,
      cnostruk,
      infokecil,
      infoutama,
      ckdstation,
      kdacc,
      cuserid,
      mainagenid;

  Reslogin(
      {required this.Trxid,
      required this.cjalurpln,
      required this.Bagian_tujuan,
      required this.ckdagen,
      required this.codeb2b,
      required this.Bagian_asal,
      required this.cnama,
      required this.userid,
      required this.cversiapp,
      required this.token,
      required this.keymlo,
      required this.clevel,
      required this.ckota,
      required this.csaldo,
      required this.Kode_produk,
      required this.cnostruk,
      required this.infokecil,
      required this.infoutama,
      required this.ckdstation,
      required this.kdacc,
      required this.cuserid,
      required this.mainagenid});

  @override
  String toString() {
    return 'Reslogin{Trxid: $Trxid, cjalurpln: $cjalurpln, Bagian_tujuan: $Bagian_tujuan, ckdagen: $ckdagen, codeb2b: $codeb2b, Bagian_asal: $Bagian_asal, cnama: $cnama, userid: $userid, cversiapp: $cversiapp, token: $token, keymlo: $keymlo, clevel: $clevel, ckota: $ckota, csaldo: $csaldo, Kode_produk: $Kode_produk, cnostruk: $cnostruk, infokecil: $infokecil, infoutama: $infoutama, ckdstation: $ckdstation, kdacc: $kdacc, cuserid: $cuserid, mainagenid: $mainagenid}';
  }

  factory Reslogin.fromJson(Map<String, dynamic> json) {
    return Reslogin(
        Trxid: json["Trxid"],
        cjalurpln: json["cjalurpln"],
        Bagian_tujuan: json["Bagian_tujuan"],
        ckdagen: json["ckdagen"],
        codeb2b: json["codeb2b"],
        Bagian_asal: json["Bagian_asal"],
        cnama: json["cnama"],
        userid: json["userid"],
        cversiapp: json["cversiapp"],
        token: '',
        keymlo: json["keymlo"],
        clevel: json["clevel"],
        ckota: json["ckota"],
        csaldo: json["csaldo"],
        Kode_produk: json["Kode_produk"],
        cnostruk: json["cnostruk"],
        infokecil: json["infokecil"],
        infoutama: json["infoutama"],
        ckdstation: json["ckdstation"],
        kdacc: json["kdacc"],
        cuserid: json["cuserid"],
        mainagenid: json["mainagenid"]);
  }
}
