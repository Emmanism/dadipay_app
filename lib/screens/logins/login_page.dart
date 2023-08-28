// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/my_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const MaterialColor black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFEEEEEE),
    100: Color(0xFFBBBBBB),
    200: Color(0xFF999999),
    300: Color(0xFF555555),
    400: Color(0xFF333333),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  final formResult = {};

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logos.png',
                height: 55,
              ),
              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: ThemeData(primarySwatch: black),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                MyInputField(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.mail_outline_outlined),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  hintText: 'Password',
                                  isPassword: true,
                                  prefixIcon: Icon(Icons.lock_outline_sharp),
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                ),
                                const SizedBox(height: 20),
                                ButtonWidget(
                                  onPress: () {},
                                  text: 'Login',
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 24, bottom: 16, left: 8, right: 8),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot');
                        },
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(color: KprimaryColor),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Create one',
                            style: TextStyle(
                                color: KprimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
