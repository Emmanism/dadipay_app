// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/opt_field.dart';
import 'package:flutter/material.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VeriryOTPState();
}

final TextEditingController otpController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
void dispose() {
  otpController.dispose();
}

class _VeriryOTPState extends State<VerifyOTP> {
  int? userId;

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> verifyOTP(String otppin) async {
    final DateTime now = DateTime.now();
    final String timestamp = now.toUtc().toIso8601String();
    //final String otprefpin = '$userId-$timestamp';
    String otprefpin = '';

    try {
      final url = '$baseUrl/api/verifyotp/$otprefpin/$otppin/user';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final bool isOTPValid = responseData['data'];
        final String sms_pinId = responseData['data']['user']['sms_pinId'];

        if (isOTPValid) {
          setState(() {
            otprefpin = sms_pinId;
            print(otprefpin);
            // Update the userId in your state
          });
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          showErrorDialog(
              'Invalid OTP', 'The entered OTP is incorrect. Please try again.');
        }
      } else {
        showErrorDialog('Server Error',
            'An error occurred while verifying the OTP. Please try again.');
      }
    } catch (e) {
      showErrorDialog('Error',
          'An error occurred. Please check your internet connection and try again.');
    }
  }

  Future<void> resendOtp() async {
    String phoneNumber = '';
    final bool dndMode = true;

    try {
      final url = '$baseUrl/api/sendotpmobile/$phoneNumber/$dndMode';
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final getPhoneNumber = responseData['data']['user']['phone_number'];
        setState(() {
          phoneNumber = getPhoneNumber;
        });
        utils.showSnackBar(context, 'OTP Resend Successfully');
      } else {
        showErrorDialog('OTP Resent Failure', 'Resent Otp not Send');
      }
    } catch (e) {
      showErrorDialog('', 'Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: KprimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Verification Code Sent',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text(
                'Your Verification Code OTP has been sent',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpField(),
                  SizedBox(width: 8),
                  OtpField(),
                  SizedBox(width: 8),
                  OtpField(),
                  SizedBox(width: 8),
                  OtpField(),
                  SizedBox(width: 8),
                  OtpField(),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                resendOtp();
              },
              child: Text(
                'Resend Otp',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonWidget(
              onPress: () {
                String otppin = otpController.text;
                if (_formKey.currentState!.validate()) {
                  verifyOTP(otppin);
                }
              },
              text: 'Verify OTP',
            )
          ],
        ),
      ),
    ));
  }
}
