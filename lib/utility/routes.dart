import 'package:arapay/screens/home/page/mini/setting/print/prtin.dart';
import 'package:flutter/widgets.dart';
import 'package:arapay/screens/main.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  PrintSetting.routeName: (context) => const PrintSetting(),
};
