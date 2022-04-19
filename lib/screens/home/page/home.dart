import 'package:arapay/components/main.dart';
import 'package:flutter/material.dart';
import 'package:arapay/utility/main.dart';

class Menu {
  final IconData icon;
  final String judul;
  final Widget miniPage;
  Menu({required this.miniPage, required this.icon, required this.judul});
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10), vertical: 20),
      height: SizeConfig.screenHeight,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemMenu.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(
            icon: itemMenu[index].icon,
            text: itemMenu[index].judul,
            miniPage: itemMenu[index].miniPage,
          );
        },
      ),
    );
  }
}
