// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:arapay/components/main.dart';
import 'package:arapay/screens/home/page/mini/view_print.dart';
import 'package:arapay/service/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({
    Key? key,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        child: FutureBuilder(
          future: ambilHistoryCon(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            snapshot.data ?? [];
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              if (snapshot.toString().contains("[]")) {
                return const Card(
                  child: ListTile(
                    title:
                        Text('Data tidak ada', style: TextStyle(fontSize: 20)),
                    subtitle: Text('Tanggal '),
                    leading: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        "1", // ambil karakter pertama text
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SafeArea(
                  child: LisrHistory(
                    snapshot: snapshot,
                    date: selectedDate,
                  ),
                );
              }
            } else {
              // result = CircularProgressIndicator();
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _selectDate(context),
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.date_range)),
    );
  }

  Future ambilHistoryCon() async {
    final prefs = await SharedPreferences.getInstance();
    String _pasword = prefs.getString("password")!;
    String _ckdagen = prefs.getString("ckdagen")!;
    String _userid = prefs.getString("cuserid")!;
    String _deviceid = prefs.getString("IdTerminal")!;
    // ========== end ambil tgl ==========================
    DateTime today;
    if (selectedDate != null) {
      today = selectedDate;
    } else {
      today = DateTime.now();
    }
    var formatternya = DateFormat('yyyy/MM/dd');
    String formattedDate = formatternya.format(today);
    String tglaa = formattedDate.substring(0, 4);
    String tglab = formattedDate.substring(5, 7);
    String tglac = formattedDate.substring(8, 10);
    String tglnya = tglaa + tglab + tglac;
    String kdAgen = _ckdagen;
    String userId = _userid;
    var idTerminal = _deviceid;
    String bacasetsapikey = "123456";
    String password = _pasword;
    try {
      return Service().post("/report/listtransaksiall",
          body: jsonEncode({
            'tglapnya': tglnya,
            'kodeagen': kdAgen,
            'userLogin': userId,
            'deviceid': idTerminal,
            'bacasetsapikey': bacasetsapikey,
            'pasword': password,
          }));
    } catch (e) {
      print("Error : ${e.toString()}");
      return null;
    }
  }
}

class LisrHistory extends StatelessWidget {
  const LisrHistory({Key? key, required this.snapshot, required this.date})
      : super(key: key);
  final AsyncSnapshot snapshot;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    int hasil = 0;

    var formatternya = DateFormat('yyyy/MM/dd');
    String formattedDate = formatternya.format(date);

    int luasPersegi(int sisi, int idx) {
      if (idx == 0) {
        hasil = sisi;
      } else {
        hasil = hasil + sisi;
      }
      return hasil;
    }

    String convertToIdr(dynamic number, int decimalDigit) {
      NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: decimalDigit,
      );
      return currencyFormatter.format(number);
    }

    String convertToIdrnoRp(dynamic number, int decimalDigit) {
      NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: decimalDigit,
      );
      return currencyFormatter.format(number);
    }

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final number = index + 1;
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Text(
              number.toString(), // ambil karakter pertama text
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          title: Text('Idpel ' + snapshot.data[index]['idpelanggan'],
              style: Theme.of(context).textTheme.headline5),
          subtitle: Wrap(
            children: [
              Text(
                'No Struk ' +
                    snapshot.data[index]['nomorstruk'] +
                    ", " +
                    'Kd Mitra ' +
                    snapshot.data[index]['kdmitra'] +
                    ", " +
                    'Kd Bar ' +
                    snapshot.data[index]['kodebarcode'] +
                    ", " +
                    'Produk ' +
                    snapshot.data[index]['kdproduktrx'] +
                    ", " +
                    'Jml Trx ' +
                    snapshot.data[index]['jmltrx'] +
                    ", " +
                    'Tanggal ' +
                    snapshot.data[index]['tanggal'] +
                    ", " +
                    'Debet ' +
                    convertToIdrnoRp(
                            int.parse(snapshot.data[index]['debet']), 0)
                        .toString() +
                    ", " +
                    'Total ' +
                    convertToIdr(
                            (luasPersegi(
                                int.parse(snapshot.data[index]['debet']),
                                index)),
                            0)
                        .toString(),
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          trailing: RoundedIconBtn(
            icon: Icons.print,
            press: () {
              cuHistoryCon(snapshot.data[index], context);
            },
          ),
        );
      },
    );
  }

  Future<void> cuHistoryCon(snapshot, context) async {
    final prefs = await SharedPreferences.getInstance();
    String _pasword = prefs.getString("password")!;
    String _ckdagen = prefs.getString("ckdagen")!;
    String _userid = prefs.getString("cuserid")!;
    int _csaldo = prefs.getInt("csaldo")!;
    String _deviceid = prefs.getString("IdTerminal")!;
    File file = File(await getFilePath()); // 1
    String kdAktivasi = await file.readAsString(); // 2
    String nama = prefs.getString("cnama")!;
    String namaPdam = "PDAM ${snapshot['kdproduktrx'].replaceAll("KAB. ", "")}";
    String isi48 = DateFormat('yyyyMMdd')
            .format(DateTime.parse(snapshot['tanggal']))
            .toString() +
        ":" +
        snapshot['nomorstruk'];
    print(isi48);

    String bit37isiStruk =
        ("000000000000" + String.fromEnvironment(snapshot['nomorstruk']))
            .substring(String.fromEnvironment(snapshot['nomorstruk']).length,
                String.fromEnvironment(snapshot['nomorstruk']).length + 12);
    print(bit37isiStruk);

    try {
      Map<String, dynamic> data = await Service().post2("/cupdam_ara2",
          body: jsonEncode({
            "CuPdam": "193000",
            "TrxId": buatSatan(),
            "Jam": formatteTime(),
            "Tgl": formattedDate(),
            "KdAgen": _ckdagen,
            "UserId": _userid,
            "Password": _pasword,
            "IdTerminal": _deviceid,
            "KdAktivasi": kdAktivasi,
            "kdProduk": "100129",
            "Chanel": "A001001",
            "NoStruk": bit37isiStruk,
            "Saldo": _csaldo,
            "NamaPdam": namaPdam,
            "isib48": isi48,
            "Signature_id":
                "$buatSatan$formatteTime$formattedDate$_ckdagen$_userid$_pasword-1237982591${kdAktivasi}100129$bit37isiStruk$namaPdam$isi48$kdAktivasi"
          }));

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ViewPrint(
            paypdamrespon: data['rescupdam'],
            nama: nama,
          );
        },
      );
    } catch (e) {
      print("Error : ${e.toString()}");
      return;
    }
  }
}
