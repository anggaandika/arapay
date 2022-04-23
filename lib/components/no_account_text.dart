import 'dart:io';

import 'package:arapay/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:arapay/utility/main.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class NoAccountText extends StatefulWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  State<NoAccountText> createState() => _NoAccountTextState();
}

class _NoAccountTextState extends State<NoAccountText> {
  String? _deviceId;
  String? _aktifasi;

  @override
  void initState() {
    super.initState();
    kdAk();
    initPlatformState();
  }

  void kdAk() async {
    File file = File(await getFilePath()); // 1
    String fileContent = await file.readAsString(); // 2

    setState(() {
      _aktifasi = fileContent;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      // print("deviceId->$_deviceId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kode Aktifasi : ",
              style: TextStyle(fontSize: getProportionateScreenWidth(16)),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
              child: Text(
                _aktifasi.toString(),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: kPrimaryColor),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenWidth(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mac Adrress : ",
              style: TextStyle(fontSize: getProportionateScreenWidth(16)),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
              child: Text(
                _deviceId.toString(),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: kPrimaryColor),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum dapat akun androidnya ? ",
              style: TextStyle(fontSize: getProportionateScreenWidth(16)),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
              child: Text(
                "Daftar Dulu",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: kPrimaryColor),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenWidth(5)),
      ],
    );
  }
}
