// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore

import 'dart:convert';
import 'dart:io';
import 'package:arapay/components/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:arapay/model/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class PdamSatu extends StatefulWidget {
  const PdamSatu({Key? key})
      : super(key: key); // ini untuk send data ke page indext.dart

  @override
  _PdamSatuState createState() => _PdamSatuState();
}

class _PdamSatuState extends State<PdamSatu> {
  TextEditingController idpelpdam = TextEditingController();

  String bacasetsapikey = '',
      _pasword = '',
      lwilayah = '',
      _ckdagen = '',
      _userid = '',
      _deviceid = '',
      _cnostruk = '';
  int _csaldo = 0;

  // ignore: non_constant_identifier_names
  void _GetData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pasword = prefs.getString("password")!;
      _ckdagen = prefs.getString("ckdagen")!;
      _userid = prefs.getString("cuserid")!;
      _cnostruk = prefs.getString("cnostruk")!;
      _csaldo = int.parse(prefs.getString("csaldo")!);
      _deviceid = prefs.getString("IdTerminal")!;
    });
  }

  @override
  void initState() {
    super.initState();
    _GetData();
  }

  // ---------------------- start dropdown--------------------
  String? _valWilayah; //_valGender
  String? _valCitys; //_valFriends

  //_listGender
  final List _listWilayah = [
    "ACEH",
    "BALI & NTB & NTT",
    "BENGKULU & BABEL",
    "DIY",
    "DKI & BANTEN",
    "JABAR",
    "JAMBI",
    "JATENG",
    "JATIM",
    "KALBAR",
    "KALSEL",
    "KALTENG",
    "KALTIM",
    "KALUT",
    "LAMPUNG",
    "MALUKU & MALUT & PAPUA",
    "RIAU & KEPRI",
    "SULBAR",
    "SULSEL",
    "SULTENG & SULTRA",
    "SULUT & GORONTALO",
    "SUMBAR",
    "SUMSEL",
    "SUMUT"
  ];

  List _myCitysfull = [];

  void prosesGetlistpdam() async {
    bacasetsapikey = "123456";

    final responseGetlistPdam = await listPdam(ListPdam(
        bacasetsapikey: bacasetsapikey,
        pasword: _pasword,
        lwilayah: _valWilayah.toString(),
        kodeagen: _ckdagen,
        userLogin: _userid,
        deviceid: _deviceid));
    final jsonResp = json.decode(responseGetlistPdam!.body);
    if (responseGetlistPdam.statusCode == 200) {
      listpdam_respon listpdamrespon = listpdam_respon.fromJson(jsonResp);
      print(listpdamrespon);
      print(listpdamrespon.sukses);
      print(listpdamrespon.datPdam);

      var datanya;
      int bagus = listpdamrespon.datPdam.length;
      var _myCitys = List.filled(bagus, '', growable: false);
      for (int x = 0; x < bagus; x++) {
        listpdamrespon.datPdam[x]["biayaadmin"];
        listpdamrespon.datPdam[x]["kdgateway"];
        listpdamrespon.datPdam[x]["nama"];
        listpdamrespon.datPdam[x]["kdmitra"];

        datanya = listpdamrespon.datPdam[x]["kdgateway"] +
            "|" +
            listpdamrespon.datPdam[x]["nama"] +
            "|" +
            listpdamrespon.datPdam[x]["biayaadmin"];

        _myCitys[x] = datanya;

        print(datanya);
      }

      setState(() {
        _myCitysfull = _myCitys;
        print(_myCitys);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenWidth(10)),
          const HeaderMiniWidget(title: 'Inquiry'),
          SizedBox(height: getProportionateScreenWidth(15)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(35)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton(
                  hint: const Text("Pilih Wilayah"),
                  iconEnabledColor: kPrimaryColor,
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  isExpanded: true,
                  value: _valWilayah,
                  items: _listWilayah.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value.toString()),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valWilayah = value
                          .toString(); //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                      prosesGetlistpdam();
                    });
                  },
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: getProportionateScreenWidth(10)),
                DropdownButton(
                  hint: const Text("Pilih Kota"),
                  iconEnabledColor: kPrimaryColor,
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  isExpanded: true,
                  value: _valCitys,
                  items: _myCitysfull.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valCitys = value
                          .toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                    });
                  },
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: getProportionateScreenWidth(20)),
                TextFormField(
                  controller: idpelpdam,
                  decoration:
                      const InputDecoration(labelText: "Masukan Id Pelanggan"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: getProportionateScreenWidth(25)),
                SizedBox(
                    width: double.infinity,
                    child: largetButton(
                        label: 'Lanjutkan',
                        iconData: Icons.subdirectory_arrow_right,
                        onPressed: () => showFancyCustomDialog(context))),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 200.0,
        width: 200.0,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                "Apakah akan melanjutkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 2.0, color: Colors.black26),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Konfirmasi",
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.black26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // loadDialog(context, "Mohon Tunggu Sebentar");
                            prosesInqPdam();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  void prosesInqPdam() async {
    // String Trxid, mainagenid = "Shared Preferences";

    // ==================== start ============
    String Inqpdamnya = "380000"; // A

    //membuat stan number automatis
    var todaystand = DateTime.now();
    String datestand = DateFormat("HHmmss").format(todaystand);
    var buatstand = (int.parse(datestand) + 1021);
    print(buatstand); // prints true();

    String TrxId = buatstand.toString(); // A

    // fungsi format Jam
    var timetoday = DateTime.now();
    String formatedjam = DateFormat('HHmmss').format(timetoday);
    print(formatedjam);

    String Jamnya = formatedjam; // A   //  "231702";

    // fungsi format Tanggal
    var today = DateTime.now();
    var formatternya = DateFormat('MMdd');
    String formattedDate = formatternya.format(today);
    print(formattedDate);

    String Tglnya = formattedDate; // A   // "1220";

    String KdAgen = _ckdagen;
    String UserId = _userid;

    String Password = _pasword;

    String? idTerminal = await PlatformDeviceId.getDeviceId;

    File file = File(await getFilePath()); // 1
    String kdAktivasi = await file.readAsString(); // ini belum
    String jur = _valCitys.toString();

    List potongkdpdam = jur.split("|");
    String juproduk =
        potongkdpdam[0].toString().replaceAll("|", ""); // tidak dipakai
    String namapdam = potongkdpdam[1].toString().replaceAll("|", "");

    String KdProduk = juproduk; //"100129";

    String Chanel = "A00" + _ckdagen; //"A00" + "1001";      //MenuUtama.kdagen;
    String NoStruk = _cnostruk;
    String NamaPdam = namapdam; //"PDAM PACITAN";
    String IdPel = idpelpdam.text; // idpel

    String SignatureId = TrxId +
        Jamnya +
        Tglnya +
        KdAgen +
        UserId +
        Password +
        idTerminal.toString() +
        kdAktivasi +
        KdProduk +
        NoStruk +
        NamaPdam +
        IdPel +
        kdAktivasi;

    try {
      final response = await InqPdamCon(
          // User(username: usernameCont.text, password: passCont.text));
          Inqpdam(
              Inqpdamnya: Inqpdamnya,
              TrxId: TrxId,
              Jamnya: Jamnya,
              Tglnya: Tglnya,
              KdAgen: KdAgen,
              UserId: UserId,
              Password: Password,
              KdAktivasi: kdAktivasi,
              IdTerminal: idTerminal.toString(),
              Responkota: '',
              KdProduk: KdProduk,
              Chanel: Chanel,
              NoStruk: NoStruk,
              Saldo: _csaldo,
              NamaPdam: NamaPdam,
              IdPel: IdPel,
              Signature_id: SignatureId));
      final jsonResp = json.decode(response!.body);
      if (response.statusCode == 200) {
        inqpdam_respon inqpdamrespon = inqpdam_respon.fromJson(jsonResp);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PdamDua(inqpdamrespon: inqpdamrespon)));
      } else if (response.statusCode == 401) {
        dialog(context, jsonResp['message']);
      } else {
        dialog(context, response.body.toString());
      }
    } catch (e) {
      dialog(context, e.toString());
    }
  }
}
