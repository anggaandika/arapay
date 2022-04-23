import 'package:flutter/material.dart';
import 'package:arapay/screens/main.dart';
import 'package:arapay/utility/main.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // run app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Home()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AraPosPay',
      theme: theme(),
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}
