// ignore_for_file: avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, unused_element, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:arapay/service/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RekeningKoran extends StatefulWidget {
  const RekeningKoran({
    Key? key,
  }) : super(key: key);

  @override
  State<RekeningKoran> createState() => _RekeningKoranState();
}

class _RekeningKoranState extends State<RekeningKoran> {
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

    @override
    void initState() {
      super.initState();
      AmbilHistoryCon();
    }

    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        child: FutureBuilder(
          future: AmbilHistoryCon(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            snapshot.data ?? [];
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.toString().contains("[]")) {
                return const Card(
                  child: ListTile(
                    title:
                        Text('Data tidak ada', style: TextStyle(fontSize: 20)),
                    subtitle: Text('Tanggal '),
                    leading: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Text("1", // ambil karakter pertama text
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                );
              } else {
                return SafeArea(
                  child: ListTransaksi(
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

  // ignore: non_constant_identifier_names
  Future AmbilHistoryCon() async {
    final prefs = await SharedPreferences.getInstance();
    String _pasword = prefs.getString("password")!;
    String _ckdagen = prefs.getString("ckdagen")!;
    String _userid = prefs.getString("cuserid")!;
    int _csaldo = int.parse(prefs.getString("csaldo")!);
    String _deviceid = prefs.getString("IdTerminal")!;
    // ========== end ambil tgl ==========================
    var today;
    // fungsi format Tanggal
    if (selectedDate != null) {
      today = selectedDate;
    } else {
      today = DateTime.now();
    }
    var formatternya = DateFormat('yyyy/MM/dd');
    String formattedDate = formatternya.format(today);
    // print(formattedDate);
    String tglaa = formattedDate.substring(0, 4);
    String tglab = formattedDate.substring(5, 7);
    String tglac = formattedDate.substring(8, 10);
    // ignore: non_constant_identifier_names
    String Tglnya = tglaa + tglab + tglac;
    // ignore: non_constant_identifier_names
    String KdAgen = _ckdagen;
    // ignore: non_constant_identifier_names
    String UserId = _userid;
    String IdTerminal = _deviceid;
    String bacasetsapikey = "123456";
    // ignore: non_constant_identifier_names
    String Password = _pasword;
    // String KdAktivasi = "ee8665b4fc"; //ini belum
    try {
      return Service().post("/report/rekon",
          body: jsonEncode({
            'tglapnya': Tglnya,
            'kodeagen': KdAgen,
            'userLogin': UserId,
            'deviceid': IdTerminal,
            'bacasetsapikey': bacasetsapikey,
            'pasword': Password
          }));
    } catch (e) {
      print("Error : ${e.toString()}");
      return null;
    }
  }
}

class ListTransaksi extends StatelessWidget {
  const ListTransaksi({Key? key, required this.snapshot, required this.date})
      : super(key: key);
  final AsyncSnapshot snapshot;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    int hasil = 0;
    int hasilDebet = 0;

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

    int totalDebet(int sisi, int idx) {
      if (idx == 0) {
        hasilDebet = sisi;
      } else {
        hasilDebet = hasilDebet + sisi;
      }
      return hasilDebet;
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
          leading: snapshot.data[index]['debet'] != '0'
              ? CircleAvatar(
                  backgroundColor: kPrimaryLightColor,
                  child: Text('$number', // ambil karakter pertama text
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                )
              : CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Text('$number', // ambil karakter pertama text
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
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
                    'Jam ' +
                    snapshot.data[index]['jam'] +
                    ", " +
                    'Tanggal ' +
                    snapshot.data[index]['tgl_trx'] +
                    ", " +
                    'Kredit ' +
                    convertToIdrnoRp(
                            int.parse(snapshot.data[index]['kredit']), 0)
                        .toString() +
                    ", " +
                    'Total Kredit ' +
                    convertToIdr(
                            (luasPersegi(
                                int.parse(snapshot.data[index]['kredit']),
                                index)),
                            0)
                        .toString() +
                    ", " +
                    'Debet ' +
                    convertToIdrnoRp(
                            int.parse(snapshot.data[index]['debet']), 0)
                        .toString() +
                    ", " +
                    'Total Debet ' +
                    convertToIdr(
                            (totalDebet(
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
        );
      },
    );
  }
}
