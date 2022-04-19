// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const IS_LOGIN = 'IS_LOGIN';
const JENIS_LOGIN = 'JENIS_LOGIN';
const ID_PASIEN = 'ID_PASIEN';
const NAMA = 'NAMA';
const RLOGIN = 'RLOGIN';
const HP = 'HP';
const EMAIL = 'EMAIL';

// enum jenisLogin { PASIEN, PEGAWAI, AGEN }
enum jenisLogin { pasien, pegawai, agen }

Future createAgenSession(String username, String reslogin) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(IS_LOGIN, true);
  prefs.setString(NAMA, username);
  prefs.setString(RLOGIN, reslogin);
  prefs.setString(JENIS_LOGIN, jenisLogin.agen.toString());
  return true;
}

// Future createPasienSession(Pasien pasien) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setBool(IS_LOGIN, true);
//   prefs.setString(ID_PASIEN, pasien.idPasien);
//   prefs.setString(NAMA, pasien.nama);
//   prefs.setString(HP, pasien.hp);
//   prefs.setString(EMAIL, pasien.email);
//   prefs.setString(JENIS_LOGIN, jenisLogin.pasien.toString());
//   return true;
// }

Future createPegawaiSession(String username) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(IS_LOGIN, true);
  prefs.setString(NAMA, username);
  prefs.setString(JENIS_LOGIN, jenisLogin.pegawai.toString());
  return true;
}

Future clearSession() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return true;
}
