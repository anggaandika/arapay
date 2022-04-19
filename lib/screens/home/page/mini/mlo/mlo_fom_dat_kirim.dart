// ignore_for_file: void_checks

import 'dart:convert';

import 'package:arapay/components/main.dart';
import 'package:arapay/service/main.dart';
import 'package:arapay/utility/main.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPaket extends StatefulWidget {
  const InfoPaket({Key? key}) : super(key: key);

  @override
  State<InfoPaket> createState() => _InfoPaketState();
}

class _InfoPaketState extends State<InfoPaket> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  // ---------------------- start dropdown--------------------
  String? _valDom;
  String? _valPaket;
  String? _valTujuan;

  final List _listDom = ['Domestik', 'Internasional'];
  final List _listPaket = ['Paket', 'Dokument'];
  static List _listTujuan = [];

  @override
  void initState() {
    setState(() {
      theCodePos();
    });
    super.initState();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('Fom Data Paket',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(25)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: buildDomestic()),
                    SizedBox(width: getProportionateScreenHeight(30)),
                    Flexible(child: buildPaket())
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildTujuan(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildBeratFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildVolumeFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildNilaiBarangFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: 'Simpan',
                  press: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecorator buildTujuan() {
    return InputDecorator(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(getProportionateScreenWidth(15)),
          labelStyle:
              const TextStyle(color: kPrimaryLightColor, fontSize: 16.0),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
          hintText: 'Please select expense',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      isEmpty: _valTujuan == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconEnabledColor: kPrimaryColor,
          icon: const Icon(Icons.arrow_drop_down_circle),
          value: _valTujuan,
          isExpanded: true,
          hint: const Text('Pilih tujuan anda!'),
          onChanged: (newValue) {
            setState(() {
              _valTujuan = newValue.toString();
            });
          },
          items: _listTujuan.map((value) {
            return DropdownMenuItem(
              value: value.toString(),
              child: Text(
                '${value["posCode"]} | ${value["city"]} | ${value["address"]}',
                style: const TextStyle(fontSize: 13.0),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  InputDecorator buildDomestic() {
    return InputDecorator(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(getProportionateScreenWidth(15)),
          labelStyle:
              const TextStyle(color: kPrimaryLightColor, fontSize: 16.0),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
          hintText: 'Please select expense',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      isEmpty: _valDom == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Pilih Wilaya"),
          iconEnabledColor: kPrimaryColor,
          icon: const Icon(Icons.arrow_drop_down_circle),
          isExpanded: true,
          value: _valDom,
          items: _listDom.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
              child: Text(
                value,
              ),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _valDom = value.toString();
            });
          },
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  InputDecorator buildPaket() {
    return InputDecorator(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(getProportionateScreenWidth(15)),
          labelStyle:
              const TextStyle(color: kPrimaryLightColor, fontSize: 16.0),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
          hintText: 'Please select expense',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      isEmpty: _valDom == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Pilih Paket"),
          iconEnabledColor: kPrimaryColor,
          icon: const Icon(Icons.arrow_drop_down_circle),
          isExpanded: true,
          value: _valPaket,
          items: _listPaket.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
              child: Text(
                value.toString(),
              ),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _valPaket = value.toString();
            });
          },
          // onTap: () => theFee(),
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  TextFormField buildBeratFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Berat Aktual",
        hintText: "Enter your berat aktual",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.wallet_giftcard),
        suffixText: "Kg",
      ),
    );
  }

  TextFormField buildVolumeFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Volume",
        hintText: "Enter your volume",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: Icons.wallet_giftcard),
      ),
    );
  }

  TextFormField buildNilaiBarangFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Nilai Barang",
        hintText: "Enter your nilai barang",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: Icons.wallet_giftcard),
        prefixText: "Rp",
      ),
    );
  }

  void theCodePos() async {
    final prefs = await SharedPreferences.getInstance();
    String _id = prefs.getString("IdTerminal")!;
    String _user = prefs.getString("cuserid")!;
    String _pasword = prefs.getString("password")!;
    String _ckdagen = prefs.getString("ckdagen")!;
    try {
      final data = await Service().post2("/nipos/getposcode",
          body: jsonEncode({
            "bacasetsapikey": "123456",
            "pasword": _pasword,
            "kodeagen": _ckdagen,
            "userLogin": _user,
            "deviceid": _id,
            "city": "Jakarta",
            "address": "",
            "location_id": "60d3efc0be8a1f0b9566ffe2",
          }));
      _listTujuan = data['rs_postcode']['r_postcode'];
    } catch (e) {
      // ignore: avoid_print
      print("Error : ${e.toString()}");
      return;
    }
  }
}
