import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:provider/provider.dart';

class ViewPrint extends StatelessWidget {
  const ViewPrint({Key? key, required this.nama, required this.paypdamrespon})
      : super(key: key);
  final Map<String, dynamic> paypdamrespon;
  final String nama;
  static const String _selectSize = "2";

  @override
  Widget build(BuildContext context) {
    var _porv = Provider.of<Home>(context, listen: false);
    return AlertDialog(
      title: Image.asset('assets/images/arra.png'),
      elevation: 0,
      content: SizedBox(
        child: Expanded(
          flex: 1,
          child: Text(
            "Nama Agen :" +
                nama +
                "\nNomer Resi :" +
                paypdamrespon['TrxId'] +
                "\nTanggal CU : " +
                DateFormat('dd-MM-yyyy').format(DateTime.now()).toString() +
                "\n\nPDAM " +
                paypdamrespon['NamaPdam'] +
                "\n\n" +
                paypdamrespon['Info1'].replaceAll("|", "\n"),
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _porv.print ? printWithoutPackage : null,
          child: const Text("Print"),
        ),
      ],
    );
  }

  void printWithoutPackage() async {
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    String text = "AraPospay \n\nNama Agen :" +
        nama +
        "\nNomer Resi :" +
        paypdamrespon['TrxId'] +
        "\nTanggal CU : " +
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString() +
        "\n\nPDAM " +
        paypdamrespon['NamaPdam'] +
        "\n\n" +
        paypdamrespon['Info1'].replaceAll("|", "\n") +
        '\n\n';
    bool result = await PrintBluetoothThermal.writeString(
        printText: PrintTextSize(size: int.parse(_selectSize), text: text));
    //impresion sin paquete solo de PrintBluetoothTermal
    StatefulBuilder(
      builder: (BuildContext context, setState) {
        if (connectionStatus) {
          // ignore: avoid_print
          print("status print result: $result");
          setState(() {});
        } else {
          //no conectado, reconecte
          setState(() {});
          // ignore: avoid_print
          print("no conectado");
        }
        return const SizedBox();
      },
    );
  }
}
