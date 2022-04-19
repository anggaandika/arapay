import 'package:arapay/components/main.dart';
import 'package:arapay/utility/size_config.dart';
import 'package:flutter/material.dart';

class Pulsa extends StatelessWidget {
  const Pulsa({Key? key}) : super(key: key);

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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                label: Text("No Hp"),
                hintText: "Isi no hp anda",
                prefixText: "+62 ",
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  leading: Icon(Icons.dangerous),
                  trailing: Text("harga"),
                  title: Text("Nomber Hp"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
