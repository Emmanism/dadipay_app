// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dadipay_app/models/user_model.dart';
import 'package:dadipay_app/providers/user_provider.dart';
import 'package:dadipay_app/routes/app_routes.dart';
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

  final AppRoutes appRoutes = AppRoutes();
  Future<void> Register(RegisterModel user, BuildContext context) async {
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
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              utils.viewShowDialog(
                  context, 'Account Created Succesfully Proceed to Verify OTP',
                  isSuccess: true);
            });
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      utils.showSnackBar(context, e.toString());
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
        final userToken = responseData['token'] as String?;
        print('Login successful: $userToken');
        // Return the user token
        print(' Login successful: $responseData');
        //After Succesfull Request
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {}
  }

  Future<void> ForgotPassword(
      ForgotPasswordModel user, BuildContext context) async {
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
        print(' OTP Sent  successful: $responseData');
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              utils.showSnackBar(context, 'OTP Sent Succesfully');
            });
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        utils.showSnackBar(context, json.decode('$responseData')['msg']);
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {}
  }

  Future<bool> verifyOTP(String enteredOTP, String otppin) async {
    final DateTime now = DateTime.now();
    final String timestamp = now.toUtc().toIso8601String();
    final String userId = '';
    final String otprefpin = '$userId-$timestamp';
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/api/verifyotp/$otprefpin/$otppin/user'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful
        final responseData = json.decode(response.body);
        // Parse the response data to check if OTP verification was successful
        final bool isVerified = responseData['isVerified'];
        return isVerified;
      } else {
        // OTP verification failed
        return false;
      }
    } catch (e) {
      // Handle any exceptions or errors here
      print('Error verifying OTP: $e');
      return false;
    }
  }
}
