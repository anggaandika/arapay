// ignore_for_file: unused_local_variable, unused_field, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:arapay/model/geter_respon.dart';
import 'package:arapay/screens/main.dart';
import 'package:arapay/utility/util/prefter.dart';
import 'package:flutter/material.dart';
import 'package:arapay/components/main.dart';
import 'package:arapay/helper/main.dart';
import 'package:arapay/model/main.dart';
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
      buatKdAk();
      readFile();
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

    File file = File(await getFilePath()); // 1
    String kdAktivasi = await file.readAsString(); // 2
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
        Reslogin loginrespon =
            Reslogin.fromJson(GetRespon.fromJson(jsonResp).respon);
        if (GetRespon.fromJson(jsonResp).success.contains("1")) {
          createAgenSession(GetRespon.fromJson(jsonResp).success,
              loginrespon.csaldo.toString());

          Map<String, dynamic> sy = {
            'password': hashed(password.toString()),
            'KdAktivasi': kdAktivasi,
            'IdTerminal': idTerminal,
          };
          Prefter().saveDataAll(GetRespon.fromJson(jsonResp).respon);
          Prefter().saveDataAll(sy);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
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
