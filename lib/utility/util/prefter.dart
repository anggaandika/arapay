import 'package:shared_preferences/shared_preferences.dart';

class Prefter {
  Future<void> saveData(String value, String title) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(title, value);
  }

  Future<void> saveDataAll(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < json.length; i++) {
      prefs.setString(
          json.keys.toList()[i], json.values.toList()[i].toString());
    }
  }

  Future<void> getDataAll(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < json.length; i++) {
      // ignore: avoid_print
      print(prefs.getString(json.keys.toList()[i]));
    }
  }

  String getDataSpesifik(values) {
    String data = "";
    _data(values).then((value) => data = value);
    return data;
  }

  Future<String> _data(String nama) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nama)!;
  }
}
