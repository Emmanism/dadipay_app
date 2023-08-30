// ignore_for_file: prefer_const_constructors

import 'package:dadipay_app/screens/logins/forgot_password.dart';
import 'package:dadipay_app/screens/logins/login_page.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/screens/logins/verify_otp.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dadipay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Onboard(),
        '/login': (context) => LoginPage(),
        '/forgot': (context) => ForgotPassword(),
        '/register': (context) => Register(),
        '/verify': (context) => VerifyOTP(),
      },
    );
  }
}
