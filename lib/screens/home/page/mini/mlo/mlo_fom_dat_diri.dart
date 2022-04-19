import 'package:arapay/components/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';

class FomDataDiri extends StatefulWidget {
  const FomDataDiri({Key? key}) : super(key: key);
  static List<String?> errors = [];

  @override
  State<FomDataDiri> createState() => _FomDataDiriState();
}

class _FomDataDiriState extends State<FomDataDiri> {
  final _formKey = GlobalKey<FormState>();
  void addError({String? error}) {
    if (!FomDataDiri.errors.contains(error)) {
      setState(() {
        FomDataDiri.errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (FomDataDiri.errors.contains(error)) {
      setState(() {
        FomDataDiri.errors.remove(error);
      });
    }
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
        title: Text('Fom Data Diri',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(getProportionateScreenWidth(25)),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              buildNamaFormField(),
              SizedBox(height: getProportionateScreenHeight(25)),
              buildAlamatFormField(),
              SizedBox(height: getProportionateScreenHeight(25)),
              buildDesaFormField(),
              SizedBox(height: getProportionateScreenHeight(25)),
              Row(
                children: [
                  Flexible(child: buildHpFormField()),
                  SizedBox(width: getProportionateScreenHeight(25)),
                  Flexible(child: buildEmailFormField()),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Row(
                children: [
                  Flexible(child: buildKotaTujuanFormField()),
                  SizedBox(width: getProportionateScreenHeight(25)),
                  Flexible(child: buildKodePosFormField()),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Flexible(child: buildNegaraFormField()),
              SizedBox(height: getProportionateScreenHeight(25)),
              DefaultButton(
                text: 'Simpan',
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your Email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.email),
        // prefixText: "Rp",
      ),
    );
  }

  TextFormField buildNamaFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Nama",
        hintText: "Enter your nama",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.person),
      ),
    );
  }

  TextFormField buildAlamatFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: 4,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Alamat",
        hintText: "Enter your Alamt",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDesaFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Desa / Kec",
        hintText: "Enter your desa / kec",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.home),
      ),
    );
  }

  TextFormField buildHpFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "No. Telp",
        hintText: "Enter your no telp",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icons.smartphone),
      ),
    );
  }

  TextFormField buildKotaTujuanFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Kota Tujuan",
        hintText: "Enter your kota tujuan",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildKodePosFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Kode Pos",
        hintText: "Enter your kode pos",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNegaraFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Negara",
        hintText: "Enter your negara",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
