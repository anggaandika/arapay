import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? nama;

String buatSatan() {
  var buatstand = int.parse(DateFormat("HHmmss").format(DateTime.now())) + 1021;
  return buatstand.toString();
}

String formattedDate() {
  return DateFormat('MMdd').format(DateTime.now());
}

String formatteTime() {
  return DateFormat('HHmmss').format(DateTime.now());
}

String hashed(hash) {
  return md5.convert(utf8.encode(hash)).toString();
}

Future<String> prefPas() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("password")!;
}

Future<String> prefCkdAgen() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("ckdagen")!;
}

Future<String> prefCuserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("cuserid")!;
}

Future<String> prefCSaldo() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("csaldo")!;
}

Future<String> prefIdTerminal() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("IdTerminal")!;
}

Future<void> clean() async {
  final _prefs = await SharedPreferences.getInstance();
  _prefs.clear();
}

Future<String> prefCNama() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("cnama")!;
}

Future<String> prefInfoUtama() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("infoutama")!;
}

Future<String> prefKDacc() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("kdacc")!;
}
