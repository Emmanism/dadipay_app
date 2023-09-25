import 'package:flutter/material.dart';

class VerifyOtpModel {
  String otp_pin;

  VerifyOtpModel({required this.otp_pin});

  Map<String, dynamic> toJson() {
    return {'otp_pin': otp_pin};
  }
}
