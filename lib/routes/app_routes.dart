import 'package:dadipay_app/screens/home_web_view.dart';
import 'package:dadipay_app/screens/logins/forgot_password/forgot_password.dart';
import 'package:dadipay_app/screens/logins/login_page.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/screens/logins/verify_otp.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String onboard = '/';
  String login = '/login';
  String register = '/register';
  String forgot = '/forgot';
  String verify = '/verify';
  String home = '/home';
  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Onboard());
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/forgot':
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeWebView());
      case '/verify':
        return MaterialPageRoute(builder: (context) => VerifyOTP());
      default:
        throw ("Undefined Routes");
    }
  }
}
