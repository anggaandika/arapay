import 'package:arapay/components/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';

class PLN extends StatelessWidget {
  const PLN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Column(
        children: [
          const HeaderMiniWidget(title: 'Pulsa'),
          SizedBox(height: getProportionateScreenWidth(20)),
          const Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("No Pelanggan"),
                hintText: "Isi no pelanggan",
                prefixIcon: Icon(Icons.bolt),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
        ],
      ),
    );
  }
}
