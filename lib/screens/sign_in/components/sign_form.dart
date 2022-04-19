// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:arapay/components/main.dart';
import 'package:arapay/helper/main.dart';
import 'package:arapay/model/main.dart';
import 'package:arapay/screens/home/home_screen.dart';
import 'package:arapay/utility/main.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  @override
  void initState() {
    setState(() {
      clean();
    });
    super.initState();
  }

  Future<void> clean() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                // onTap: () => Navigator.pushNamed(
                //     context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                prosesLogin();
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 2) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 2) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "User Id",
        hintText: "Enter your user id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.person),
      ),
    );
  }

  Future<dynamic> prosesLogin() async {
    int csaldo = 0;

    String? idTerminal = await PlatformDeviceId.getDeviceId;

    String kdAktivasi = "ee8665b4fc";
    String versi = "4.06";
    String usid = email.toString();

    String signatureid = buatSatan() +
        "" +
        formatteTime() +
        "" +
        formattedDate() +
        "" +
        usid +
        "" +
        hashed(password.toString()) +
        "" +
        idTerminal! +
        "" +
        kdAktivasi +
        "" +
        versi +
        "" +
        kdAktivasi;

    try {
      final response = await login(User(
          trxId: buatSatan(),
          jam: formatteTime(),
          tgl: formattedDate(),
          userId: usid,
          password: hashed(password.toString()),
          idTerminal: idTerminal,
          kdAktivasi: kdAktivasi,
          versi: versi,
          signatureid: signatureid));
      final jsonResp = json.decode(response!.body);
      if (response.statusCode == 200) {
        login_respon loginrespon = login_respon.fromJson(jsonResp);

        if (loginrespon.success.contains("1")) {
          createAgenSession(
              loginrespon.success, loginrespon.reslogin.csaldo.toString());

          void _saveData() async {
            final prefs = await SharedPreferences.getInstance();
            setState(() {
              prefs.setString('password', hashed(password.toString()));
              prefs.setString('IdTerminal', idTerminal);
              prefs.setString('KdAktivasi', kdAktivasi);
              prefs.setString('Trxid', loginrespon.reslogin.Trxid.toString());
              prefs.getString("Trxid")!;
              prefs.setString(
                  'cjalurpln', loginrespon.reslogin.cjalurpln.toString());
              prefs.getString("cjalurpln")!;
              prefs.setString('Bagian_tujuan',
                  loginrespon.reslogin.Bagian_tujuan.toString());
              prefs.getString("Bagian_tujuan")!;
              prefs.setString(
                  'ckdagen', loginrespon.reslogin.ckdagen.toString());
              prefs.getString("ckdagen")!;
              prefs.setString(
                  'codeb2b', loginrespon.reslogin.codeb2b.toString());
              prefs.getString("codeb2b")!;
              prefs.setString(
                  'Bagian_asal', loginrespon.reslogin.Bagian_asal.toString());
              prefs.getString("Bagian_asal")!;
              prefs.setString('cnama', loginrespon.reslogin.cnama.toString());
              prefs.getString("cnama")!;
              prefs.setString('userid', loginrespon.reslogin.userid.toString());
              prefs.getString("userid")!;
              prefs.setString(
                  'cversiapp', loginrespon.reslogin.cversiapp.toString());
              prefs.getString("cversiapp")!;
              prefs.setString('token', loginrespon.reslogin.token.toString());
              prefs.getString("token")!;
              prefs.setString('keymlo', loginrespon.reslogin.keymlo.toString());
              prefs.getString("keymlo")!;
              prefs.setString('clevel', loginrespon.reslogin.clevel.toString());
              prefs.getString("clevel")!;
              prefs.setString('ckota', loginrespon.reslogin.ckota.toString());
              prefs.getString("ckota")!;
              prefs.setInt(
                  'csaldo', int?.tryParse(loginrespon.reslogin.csaldo)!);
              prefs.getInt("csaldo")!;
              prefs.setString(
                  'Kode_produk', loginrespon.reslogin.Kode_produk.toString());
              prefs.getString("Kode_produk")!;
              prefs.setString(
                  'cnostruk', loginrespon.reslogin.cnostruk.toString());
              prefs.getString("cnostruk")!;
              prefs.setString(
                  'infokecil', loginrespon.reslogin.infokecil.toString());
              prefs.getString("infokecil")!;
              prefs.setString(
                  'infoutama', loginrespon.reslogin.infoutama.toString());
              prefs.getString("infoutama")!;
              prefs.setString(
                  'ckdstation', loginrespon.reslogin.ckdstation.toString());
              prefs.getString("ckdstation")!;
              prefs.setString('kdacc', loginrespon.reslogin.kdacc.toString());
              prefs.getString("kdacc")!;
              prefs.setString(
                  'cuserid', loginrespon.reslogin.cuserid.toString());
              prefs.getString("cuserid")!;
              prefs.setString(
                  'mainagenid', loginrespon.reslogin.mainagenid.toString());
              prefs.getString("mainagenid")!;
            });
          }

          _saveData();

          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          // direct to home pegawai here
          // createPegawaiSession(jsonResp['user']['username']);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => IndexPegawai.IndexPage()));

          dialog(context, "Password atau USerid salah");
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
