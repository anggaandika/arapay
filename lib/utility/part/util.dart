// ignore_for_file: unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:arapay/screens/main.dart';
import 'package:arapay/utility/main.dart';

dialog(_context, msg, {title}) {
  showDialog(
    context: _context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? 'Perhatian!'),
        content: Text(msg),
      );
    },
  );
}

loadDialog(
  _context,
  msg,
) {
  showDialog(
    context: _context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            const RefreshProgressIndicator(
                backgroundColor: Colors.transparent, color: Colors.orange),
            SizedBox(width: getProportionateScreenWidth(20)),
            Text(msg + '!')
          ],
        ),
      );
    },
  );
}

// Template button lebar utk posisi bottomNavigationBar
Widget largetButton(
    {String label = "Simpan",
    required IconData iconData,
    required VoidCallback onPressed}) {
  iconData = iconData;
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: new TextButton.icon(
        label: Text(
          label,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 16.0,
          ),
        ),
        icon: Icon(iconData, color: kPrimaryColor),
        onPressed: onPressed),
  );
}

// fungsi format tulisan rupiah
String toRupiah(int val) {
  // return NumberFormat.currency(locale: 'IDR').format(val);
  return NumberFormat.currency(symbol: 'Rp ').format(val);
}

void logOut(BuildContext context) {
  clearSession().then((value) => Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const SignInScreen();
      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }),
      (route) => false));
}

todayDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String formattedTime = DateFormat('kk:mm:a').format(now);
  String formattedDate = formatter.format(now);
  print(formattedTime);
  print(formattedDate);
}
