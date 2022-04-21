import 'package:flutter/material.dart';
import 'package:arapay/utility/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubTitel extends StatefulWidget {
  const SubTitel({Key? key}) : super(key: key);

  @override
  State<SubTitel> createState() => _SubTitelState();
}

class _SubTitelState extends State<SubTitel> {
  int _csaldo = 0;
  // ignore: non_constant_identifier_names
  void _GetData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _csaldo.text = prefs.getString("csaldo");
      _csaldo = int.parse(prefs.getString("csaldo")!);

      // ignore: avoid_print
      print(context.read<Home>().countPage);
    });
  }

  @override
  void initState() {
    super.initState();
    _GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Saldo  : " + toRupiah(_csaldo).toString() + ',-',
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.right,
    );
  }
}
