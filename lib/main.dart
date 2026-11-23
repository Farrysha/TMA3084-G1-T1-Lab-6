import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() => runApp(const HotelDemoApp());

class HotelDemoApp extends StatelessWidget {
  const HotelDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Suites',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: SignupPage.routeName,
      routes: <String, WidgetBuilder>{
        SignupPage.routeName: (BuildContext context) => const SignupPage(),
        LoginPage.routeName: (BuildContext context) => const LoginPage(),
      },
    );
  }
}