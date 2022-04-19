// ignore_for_file: avoid_print

import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:provider/provider.dart';

class PrintSetting extends StatefulWidget {
  static String routeName = "/print";
  const PrintSetting({Key? key}) : super(key: key);

  @override
  State<PrintSetting> createState() => _PrintSettingState();
}

class _PrintSettingState extends State<PrintSetting> {
  String _info = "";
  String _msj = '';
  List<BluetoothInfo> items = [];
  final List<String> _options = [
    "permission bluetooth granted",
    "bluetooth enabled",
    "connection status",
    "update info"
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    var _prov = Provider.of<Home>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Setting Print',
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
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Column(
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
                        visible: _prov.print,
                        child: const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                              strokeWidth: 1, backgroundColor: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(_prov.print ? "Connecting" : "Search"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _prov.print ? disconnect : null,
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
              ),
            ),
          ],
        ),
      ),
    );
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

  Future<void> disconnect() async {
    var _porv = Provider.of<Home>(context, listen: false);
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      _porv.print = false;
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

  Future<void> initPlatformState() async {
    var _porv = Provider.of<Home>(context, listen: false);
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
      _porv.print = true;
    } else {
      _msj = "Bluetooth not enabled";
      _porv.print = false;
    }

    setState(() {
      _info = platformVersion + " ($porcentbatery% battery)";
    });
  }

  Future<void> connect(String mac) async {
    var _porv = Provider.of<Home>(context, listen: false);
    setState(() {
      _porv.print = true;
    });
    final bool result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) _porv.print = true;
    // setState(() {
    //   _porv.print = false;
    // });
  }
}
