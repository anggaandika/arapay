import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.icon,
    this.text,
    required this.miniPage,
  }) : super(key: key);
  final IconData icon;
  final dynamic text;
  final Widget miniPage;
  @override
  Widget build(BuildContext context) {
    var _prov = Provider.of<Home>(context, listen: false);

    return InkWell(
      onTap: () {
        _prov.menuTogel = true;
        _prov.fiture = miniPage;
        _prov.titel = text;
      },
      child: Container(
        width: getProportionateScreenWidth(0),
        height: getProportionateScreenWidth(5),
        margin: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: .5,
              spreadRadius: .1,
              color: kSecondaryColor,
              offset: Offset.zero,
              blurStyle: BlurStyle.inner,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kPrimaryLightColor,
            ),
            Text(
              "$text",
              style: const TextStyle(
                  color: kPrimaryLightColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            )
          ],
        ),
      ),
    );
  }
}
