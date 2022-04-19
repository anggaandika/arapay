// ignore_for_file: avoid_print, library_prefixes, prefer_final_fields
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
// import 'package:image/image.dart' as Imag;

class Print extends StatefulWidget {
  final Map<String, dynamic> paypdamrespon;
  final String titel;
  const Print({Key? key, required this.paypdamrespon, required this.titel})
      : super(key: key);

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  String _info = "";
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  List<String> _options = [
    "permission bluetooth granted",
    "bluetooth enabled",
    "connection status",
    "update info"
  ];

  String _selectSize = "2";
  bool _connceting = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
        title: Text('Print ${widget.titel}',
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          PopupMenuButton(
            elevation: 3.2,
            //initialValue: _options[1],
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'Menu',
            onSelected: (Object select) async {
              String sel = select as String;
              print("selected: $sel");
              if (sel == "permission bluetooth granted") {
                bool status =
                    await PrintBluetoothThermal.isPermissionBluetoothGranted;
                setState(() {
                  _info = "permission bluetooth granted: $status";
                });
              } else if (sel == "bluetooth enabled") {
                bool state = await PrintBluetoothThermal.bluetoothEnabled;
                setState(() {
                  _info = "Bluetooth enabled: $state";
                });
              } else if (sel == "update info") {
                initPlatformState();
              } else if (sel == "connection status") {
                final bool result =
                    await PrintBluetoothThermal.connectionStatus;
                setState(() {
                  _info = "connection status: $result";
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return _options.map((String option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('info: $_info\n '),
              Text(_msj),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getBluetoots();
                    },
                    child: Row(
                      children: [
                        Visibility(
                          visible: _connceting,
                          child: const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                                strokeWidth: 1, backgroundColor: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(_connceting ? "Connecting" : "Search"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: connected ? disconnect : null,
                    child: const Text("Disconnect"),
                  ),
                ],
              ),
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: ListView.builder(
                    itemCount: items.isNotEmpty ? items.length : 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          String mac = items[index].macAdress;
                          connect(mac);
                        },
                        title: Text('Name: ${items[index].name}'),
                        subtitle: Text("macAdress: ${items[index].macAdress}"),
                      );
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: Column(children: [
                  const Text("Contoh Data Print"),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          // "This is Respon of Payment PDAM/nThis is Respon of Payment PDAM/nThis is Respon of Payment PDAM/nThis is Respon of Payment PDAM/nThis is Respon of Payment PDAM/nThis is Respon of Payment PDAM/nThis is Respon of Payment PDAM/n",
                          "PDAM " +
                              widget.paypdamrespon['NamaPdam'] +
                              "\n\n" +
                              widget.paypdamrespon['Info1']
                                  .replaceAll("|", "\n"),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: connected ? printWithoutPackage : null,
                    child: const Text("Print"),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    //print("bluetooth enabled: $result");
    if (result) {
      _msj = "Bluetooth enabled, please search and connect";
      connected = true;
    } else {
      _msj = "Bluetooth not enabled";
      connected = false;
    }

    setState(() {
      _info = platformVersion + " ($porcentbatery% battery)";
    });
  }

  Future<void> getBluetoots() async {
    final List<BluetoothInfo> listResult =
        await PrintBluetoothThermal.pairedBluetooths;

    /*await Future.forEach(listResult, (BluetoothInfo bluetooth) {
      String name = bluetooth.name;
      String mac = bluetooth.macAdress;
    });*/

    if (listResult.isEmpty) {
      _msj =
          "There are no bluetoohs linked, go to settings and link the printer";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect(String mac) async {
    setState(() {
      _connceting = true;
    });
    final bool result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) connected = true;
    setState(() {
      _connceting = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("status disconnect $status");
  }

  Future<void> printString() async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      String enter = '\n';
      await PrintBluetoothThermal.writeBytes(enter.codeUnits);
      //size of 1-5
      String text = "Hello";
      await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: 1, text: text));
      await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: 2, text: text + " size 2"));
      await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: 3, text: text + " size 3"));
    } else {
      //desconectado
      print("desconectado bluetooth $conexionStatus");
    }
  }

  Future<void> printWithoutPackage() async {
    //impresion sin paquete solo de PrintBluetoothTermal
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      String text = "PDAM " +
          widget.paypdamrespon['NamaPdam'] +
          "\n\n" +
          widget.paypdamrespon['Info1'].replaceAll("|", "\n") +
          '\n\n\n';
      // + "\n        Bukti Pembayaran,       \n      Demikian Terima kasih     \n\n\n";
      bool result = await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: int.parse(_selectSize), text: text));
      print("status print result: $result");
      setState(() {
        _msj = "printed status: $result";
      });
    } else {
      //no conectado, reconecte
      setState(() {
        _msj = "no connected device";
      });
      print("no conectado");
    }
  }
}
