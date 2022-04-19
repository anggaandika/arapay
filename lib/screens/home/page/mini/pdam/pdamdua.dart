import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:arapay/model/PDAM/main.dart';
import 'package:arapay/screens/main.dart';
import 'package:arapay/utility/main.dart';

class PdamDua extends StatefulWidget {
  // property
  final inqpdam_respon
      inqpdamrespon; // ini terima send data dari page sebelumnya

  // constructor
  const PdamDua({Key? key, required this.inqpdamrespon})
      : super(key: key); // ini terima send data dari page sebelumnya

  @override
  // ignore: no_logic_in_create_state
  _PdamDuaState createState() => _PdamDuaState(inqpdamrespon: inqpdamrespon);
}

class _PdamDuaState extends State<PdamDua> {
  // property
  inqpdam_respon inqpdamrespon; // ini terima send data dari page sebelumnya

  // constructor
  _PdamDuaState({required this.inqpdamrespon})
      : super(); // ini terima send data dari page sebelumnya

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // here
        child: SafeArea(
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                // prov.submit(true);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const PdamSatu()));
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            shape: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            // leading: Icon(Icons.menu),
            centerTitle: true,
            title: Text(
              "Respon Inquiry Pdam",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "PDAM " +
                  inqpdamrespon.resinqpdam.NamaPdam +
                  "\n\n" +
                  inqpdamrespon.resinqpdam.Info1.replaceAll("|", "\n"),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                showFancyCustomDialog(context);
              },
              child: const Text("Bayar"),
            ),
          ],
        ),
      ),
    );
  }

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 200.0,
        width: 200.0,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                "Do you want to Pay",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 2.0, color: Colors.black26),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Confirmation",
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.black26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // setState(() {
                            //   if (prov.theSubmint != true) {
                            FutureBuilder(
                              future: prosesPayPdam(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return loadDialog(
                                        context, "Mohon Tunggu Sebentar");
                                  case ConnectionState.done:
                                    break;
                                }
                                return const CircularProgressIndicator();
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  Future prosesPayPdam() async {
    // ==================== start ============
    String payPdamNya = "170000"; // A

    String trxIdPay = inqpdamrespon.resinqpdam.TrxId;
    String jamPay = inqpdamrespon.resinqpdam.Jam;
    String tglPay = inqpdamrespon.resinqpdam.Tgl;
    String noStrukPay = inqpdamrespon.resinqpdam.NoStruk;
    String saldoPay = inqpdamrespon.resinqpdam.Saldo;
    String chanelPay = inqpdamrespon.resinqpdam.Chanel;
    String kd41Pay = inqpdamrespon.resinqpdam.Kd41;
    String kdAgenPay = inqpdamrespon.resinqpdam.KdAgen;
    String userIdPay = inqpdamrespon.resinqpdam.UserId;
    String passwordPay = inqpdamrespon.resinqpdam.Password;
    String idTerminalPay = inqpdamrespon.resinqpdam.IdTerminal;
    String kdAktivasiPay = inqpdamrespon.resinqpdam.KdAktivasi;
    String idPelPay = inqpdamrespon.resinqpdam.IdPel;
    String namaPdamPay = inqpdamrespon.resinqpdam
        .NamaPdam; // untuk report di rincian, nama field dbnya kdproduktrx
    String kdProdukPay = inqpdamrespon.resinqpdam.kdProduk;
    String nominalPay = inqpdamrespon.resinqpdam.nominal;
    String jmltrxPay = inqpdamrespon.resinqpdam.Jmltrx;
    String info1Pay = inqpdamrespon.resinqpdam.Info1;
    String signatureIdPay = trxIdPay +
        jamPay +
        tglPay +
        kdAgenPay +
        userIdPay +
        passwordPay +
        idTerminalPay +
        kdAktivasiPay +
        kdProdukPay +
        noStrukPay +
        namaPdamPay +
        idPelPay +
        kdAktivasiPay;

    try {
      final response = await PayPdamConnect(
          // User(username: usernameCont.text, password: passCont.text));
          Paypdam(
              PayPdam_nya: payPdamNya,
              TrxId: trxIdPay,
              Jam: jamPay,
              Tgl: tglPay,
              Kd41: kd41Pay,
              KdAgen: kdAgenPay,
              UserId: userIdPay,
              Password: passwordPay,
              IdTerminal: idTerminalPay,
              KdAktivasi: kdAktivasiPay,
              kdProduk: kdProdukPay,
              Chanel: chanelPay,
              NoStruk: noStrukPay,
              Saldo: saldoPay,
              NamaPdam: namaPdamPay,
              IdPel: idPelPay,
              nominal: nominalPay,
              Jmltrx: jmltrxPay,
              Info1: info1Pay,
              Info2: "Info2",
              Info3: "Info3",
              Signature_id: signatureIdPay));
      final jsonResp = json.decode(response!.body);
      if (response.statusCode == 200) {
        paypdam_respon paypdamrespon = paypdam_respon.fromJson(jsonResp);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Print(
                      paypdamrespon: jsonResp,
                      titel: 'Print',
                    )));

        if (paypdamrespon.success.contains("1")) {
        } else {
          dialog(context, "Respon Code " + paypdamrespon.respaypdam.bit39);
        }
      } else if (response.statusCode == 401) {
        dialog(context, jsonResp['message']);
      } else {
        dialog(context, response.body.toString());
      }
    } catch (e) {
      dialog(context, e.toString());
    }
  }
}
