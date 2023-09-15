// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
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

 
  @override
  void dispose() {
    otpController.dispose();
  }
  

class _VeriryOTPState extends State<VerifyOTP> {
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
                'Your Verification Code OTP has been sent  ',
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
            Row(
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
            Text(
              'Didnt Receive Code ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonWidget(
               onPress: () {
           String enteredOTP = otpController.text;
           //  Check if the entered OTP matches the one sent to the user
         String sentOTP = "12345"; // Replace with the actual OTP sent to the user
              if (enteredOTP == sentOTP) {
           // If the OTP is valid, you can proceed with user verification
          // You can navigate to the next screen or perform other actions here
          Navigator.of(context).pushReplacementNamed('/home'); // Example navigation
        } else {
         // If the OTP is invalid, show an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid OTP"),
            content: Text("The entered OTP is incorrect. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
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
