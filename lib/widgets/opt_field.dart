// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatefulWidget {
  const OtpField({this.controller});

  final TextEditingController? controller;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

final TextEditingController otpController = TextEditingController();

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      children: [
        SizedBox(
          height: 68,
          width: 64,
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              } else if (value.length == -1) {
                FocusScope.of(context).previousFocus();
              }
            },
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        )
      ],
    ));
  }
}
