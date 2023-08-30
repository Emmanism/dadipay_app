// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:dadipay_app/models/user_model.dart';
import 'package:dadipay_app/screens/logins/models/login_model.dart';
import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ApiClient {
  //Registration Route Api
  Future<void> Register(RegisterModel user) async {
    var response;
    try {
      response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: jsonEncode(user.toJson()),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.isOk) {
        return response;
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response.statusText}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e);
      return response;
    }
  }

  //Login Routes Api
  Future<void> Login(LogInModel user) async {
    var response;
    try {
      response = await http
          .post(Uri.parse('$baseUrl/login'), body: user.toJson(), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/vnd.api+json',
      });
      if (response.isOk) {
        return response;
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response.statusText}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e);
      return response;
    }
  }
}
