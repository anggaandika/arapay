import 'package:arapay/screens/main.dart';
import 'package:flutter/material.dart';

List<Menu> itemMenu = [
  Menu(
    icon: Icons.water_drop,
    judul: "PDAM",
    miniPage: const PdamSatu(),
  ),
  Menu(
    icon: Icons.airport_shuttle,
    judul: "MLO",
    miniPage: const MLO(),
  ),
  Menu(
      icon: Icons.bolt,
      judul: "PLN",
      miniPage: Container(
        color: Colors.white,
        child: const PLN(),
      )),
  Menu(
    icon: Icons.phone_android,
    judul: "PULSA",
    miniPage: const Pulsa(),
  ),
  Menu(
    icon: Icons.phone_android,
    judul: "PASCA BAYAR",
    miniPage: const Pulsa(),
  ),
];
