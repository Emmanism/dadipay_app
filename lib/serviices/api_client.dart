// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dadipay_app/models/user_model.dart';
import 'package:dadipay_app/providers/user_provider.dart';
import 'package:dadipay_app/screens/home_web_view.dart';
import 'package:dadipay_app/screens/logins/forgot_password/models/forgot_password_model.dart';
import 'package:dadipay_app/screens/logins/models/login_model.dart';
import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  //Route API For Registration
  Future<void> Register(RegisterModel user) async {
    try {
      UserModel userModel = UserModel(
        id: '',
        token: '',
        smsPinId: '',
        role: '',
        firstName: user.firstName,
        lastName: user.lastName,
        middleName: user.middleName,
        occupation: user.occupation,
        userName: user.userName,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        password: user.password,
        email: user.email,
        passwordConfirmation: user.passwordConfirmation,
      );
      http.Response response = await http.post(Uri.parse('$baseUrl/register'),
          body: jsonEncode(userModel.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(' Registered successful: $responseData');
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Login Routes Api
  Future<void> Login(LogInModel user, BuildContext context) async {
    try {
      http.Response response = await http.post(Uri.parse('$baseUrl/login'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(' Login successful: $responseData');
        //After Succesfull Request
        //Navigate to HomeWebView
        Navigator.pushNamed(context, '/home');
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {}
  }

  Future<void> ForgotPassword(ForgotPasswordModel user) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/forgetpassword'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(' OTP Seent  successful: $responseData');
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e);
    }
  }
}
