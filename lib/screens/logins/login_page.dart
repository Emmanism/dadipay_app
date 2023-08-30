// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:dadipay_app/screens/logins/models/login_model.dart';
import 'package:dadipay_app/serviices/api_client.dart';
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
  final _login_formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient apiClient = ApiClient();
  final formResult = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    apiClient.Login(LogInModel(
        email: emailController.text, password: passwordController.text));
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
                            key: _login_formKey,
                            child: Column(
                              children: [
                                MyInputField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.mail_outline_outlined),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  isPassword: true,
                                  prefixIcon: Icon(Icons.lock_outline_sharp),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                const SizedBox(height: 20),
                                ButtonWidget(
                                  onPress: () {
                                    if (_login_formKey.currentState!
                                        .validate()) {
                                      loginUser();
                                    }
                                  },
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
