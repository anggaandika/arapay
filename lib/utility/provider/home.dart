import 'package:flutter/cupertino.dart';

class Home with ChangeNotifier {
  int _countPage = 0;
  bool _menuTogel = false;
  bool _print = false;
  Widget _fiture = Container();
  String _title = "";

  int get countPage => _countPage;
  bool get menuTogel => _menuTogel;
  bool get print => _print;
  Widget get fiture => _fiture;
  String get title => _title;

  set print(bool chek) {
    _print = chek;
    notifyListeners();
  }

  set countPage(int index) {
    _countPage = index;
    notifyListeners();
  }

  set menuTogel(bool chek) {
    _menuTogel = chek;
    notifyListeners();
  }

  set fiture(Widget fiture) {
    _fiture = fiture;
    notifyListeners();
  }

  set titel(String titel) {
    _title = titel;
    notifyListeners();
  }
}
