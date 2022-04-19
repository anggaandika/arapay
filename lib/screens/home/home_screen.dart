import 'package:flutter/material.dart';
import 'package:arapay/components/main.dart';
import 'package:arapay/screens/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  static final List<Widget> _page = [
    const HomePage(),
    const History(),
    const RekeningKoran(),
    const Profil(),
  ];
  static final List<NavigationItem> _bottomNavigasiItem = [
    NavigationItem(label: "", icon: Icons.home),
    NavigationItem(label: "", icon: Icons.receipt_long),
    NavigationItem(label: "", icon: Icons.newspaper),
    NavigationItem(label: "", icon: Icons.person),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var _prov = Provider.of<Home>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                getProportionateScreenWidth(20),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Image.asset('assets/images/arra.png', color: Colors.white),
        ),
        actions: [
          _prov.countPage != 3
              ? const Center(
                  child: TitelCostume(),
                )
              : Container(width: getProportionateScreenWidth(170)),
          SizedBox(
            width: getProportionateScreenWidth(25),
          ),
          _prov.countPage != 3
              ? IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SignInScreen.routeName);
                    clean();
                    Future.delayed(
                      const Duration(seconds: 10),
                      () => _prov.countPage = 0,
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: _prov.menuTogel != true
                ? _prov.countPage != 0
                    ? Text(
                        _prov.countPage != 1 && _prov.countPage != 2
                            ? "Profil"
                            : _prov.countPage != 2
                                ? "History"
                                : "Rekening Koran",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.right,
                      )
                    : const SubTitel()
                : Text(_prov.title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.right),
          ),
        ),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      body: _prov.menuTogel != true ? _page[_prov.countPage] : _prov.fiture,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigasiItem
            .map(
              (e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon,
                    color: kPrimaryColor,
                  ),
                  label: e.label),
            )
            .toList(),
        elevation: 1,
        selectedIconTheme: const IconThemeData(color: Colors.blue, size: 35),
        iconSize: 25,
        currentIndex: _prov.countPage,
        selectedItemColor: kPrimaryColor,
        onTap: (index) {
          _prov.countPage = index;
          _prov.menuTogel = false;
        },
      ),
    );
  }
}

class TitelCostume extends StatefulWidget {
  const TitelCostume({
    Key? key,
  }) : super(key: key);

  @override
  State<TitelCostume> createState() => _TitelCostumeState();
}

class _TitelCostumeState extends State<TitelCostume> {
  String _ckdagen = "0";
  String _kDacc = "";
  // ignore: non_constant_identifier_names
  void _GetData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _ckdagen.text = prefs.getString("ckdagen");
      _ckdagen = prefs.getString("ckdagen")!;
      _kDacc = prefs.getString("kdacc")!;
    });
  }

  @override
  void initState() {
    super.initState();
    _GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kode Agen : $_ckdagen",
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.justify,
        ),
        Text(
          "No Dirian : $_kDacc",
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class NavigationItem {
  final String label;
  final IconData icon;
  NavigationItem({required this.label, required this.icon});
}
