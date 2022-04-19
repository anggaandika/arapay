import 'package:arapay/components/product_card.dart';
import 'package:arapay/screens/home/page/mini/setting/print/prtin.dart';
import 'package:flutter/material.dart';
import 'package:arapay/screens/home/components/main.dart';
import 'package:arapay/screens/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String _ckdagen = "0";
  String _kDacc = "";
  // ignore: non_constant_identifier_names
  void _GetData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _ckdagen.text = prefs.getString("ckdagen");
      _ckdagen = prefs.getString("ckdagen")!;
      _kDacc = prefs.getString("kdacc")!;
      // ignore: avoid_print
      print(context.read<Home>().countPage);
    });
  }

  @override
  void initState() {
    super.initState();
    _GetData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const ProfilePic(),
          const SizedBox(height: 20),
          identity(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: Icons.person,
            press: () =>
                Navigator.pushNamed(context, CompleteProfileScreen.routeName),
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: Icons.notifications,
          //   press: () {},
          // ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: Icons.settings,
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Settings Print",
            icon: Icons.print,
            press: () => Navigator.pushNamed(context, PrintSetting.routeName),
          ),
          ProfileMenu(
            text: "Help Center",
            icon: Icons.question_mark,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            press: () {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              clean();
            },
          ),
        ],
      ),
    );
  }

  Row identity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProductCard(active: true, title: 'Kode Agen', subtitle: _ckdagen),
        ProductCard(active: true, title: 'No Dirian', subtitle: _kDacc),
      ],
    );
  }
}
