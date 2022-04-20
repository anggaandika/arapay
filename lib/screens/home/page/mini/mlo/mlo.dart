import 'dart:convert';

import 'package:arapay/components/default_button.dart';
import 'package:arapay/components/header_mini_widget.dart';
import 'package:arapay/screens/home/page/mini/mlo/mlo_fom_dat_diri.dart';
import 'package:arapay/screens/home/page/mini/mlo/mlo_fom_dat_kirim.dart';
import 'package:arapay/service/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';

class MLO extends StatefulWidget {
  const MLO({Key? key}) : super(key: key);

  @override
  State<MLO> createState() => _MLOState();
}

class _MLOState extends State<MLO> {
  // ---------------------- start dropdown--------------------
  static String? _valWilayah; //_valGender

  static List _listWilayah = [];
  @override
  void initState() {
    theFee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Column(
        children: [
          const HeaderMiniWidget(title: 'MLO'),
          const MiniPreviewData(data: 'Info Paket', page: InfoPaket()),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: InputDecorator(
              decoration: InputDecoration(
                  labelStyle: const TextStyle(
                      color: kPrimaryLightColor, fontSize: 16.0),
                  errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _valWilayah == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: const Text("Pilih Wilayah"),
                  iconEnabledColor: kPrimaryColor,
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  isExpanded: true,
                  value: _valWilayah,
                  items: _listWilayah.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      child: Text(
                          '${value["service_name"]} | Harga : ${value["price"]} | Waktu : ${value["tariff_sla_day"]}'),
                      value: value.toString(),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valWilayah = value.toString();
                    });
                  },
                  // onTap: () => theFee(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const MiniPreviewData(
              data: 'data diri pengirim', page: FomDataDiri()),
          const MiniPreviewData(
              data: 'data diri penerima', page: FomDataDiri()),
          Expanded(child: Container()),
          DefaultButton(
            text: 'Prosess',
            press: () {},
          ),
        ],
      ),
    );
  }

  void theFee() async {
    try {
      Map<String, dynamic> data = await Service().post2("/nipos/getfee",
          body: jsonEncode({
            "bacasetsapikey": "123456",
            "pasword": "202cb962ac59075b964b07152d234b70",
            "kodeagen": "1001",
            "userLogin": "bembi3",
            "deviceid": "-1237982591",
            "customer_code": "",
            "origin_data_customer_zip_code": "10220",
            "destination_data_customer_zip_code": "10220",
            "koli_length": "0",
            "koli_height": "0",
            "koli_description": "",
            "koli_volume": "0",
            "koli_weight": "4",
            "koli_chargeable_weight": "0",
            "koli_width": "0",
            "custom_field": "0",
            "location_id": "60d3efc0be8a1f0b9566ffe2",
          }));

      _listWilayah = data['data'];
    } catch (e) {
      // print("Error : ${e.toString()}");
      return;
    }
  }
}

class MiniPreviewData extends StatelessWidget {
  const MiniPreviewData({
    Key? key,
    this.data = 'data',
    required this.page,
  }) : super(key: key);
  final String data;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(10),
        ),
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenWidth / 5,
          child: Center(
            child: Text(
              data.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: kTextColor),
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(20))),
      ),
    );
  }
}
