// ignore_for_file: prefer_const_constructors

import 'package:dadipay_app/screens/home_web_view.dart';
import 'package:dadipay_app/screens/logins/forgot_password/forgot_password.dart';
import 'package:dadipay_app/screens/logins/login_page.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/screens/logins/verify_otp.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isViewed = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getBool('isViewed') ?? true;
  await preferences.setBool('isViewed', true);
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
        colorScheme: ColorScheme.fromSeed(seedColor: KprimaryColor),
        useMaterial3: true,
      ),
      initialRoute: isViewed == false ? '/' : '/login',
      routes: {
        '/': (context) => Onboard(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeWebView(),
        '/forgot': (context) => ForgotPassword(),
        '/register': (context) => Register(),
        '/verify': (context) => VerifyOTP(),
      },
    );
  }
}
