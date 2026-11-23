// Local preview entry point for Member 1 only.
//
// Member 5 owns the real lib/main.dart. Use this file to run and screenshot
// just the signup and login pages before integration:
//
//   flutter run -t lib/main_demo.dart
//
// Delete it (or leave it, it is harmless) once main.dart is wired up.

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