import 'dart:convert';

import 'package:dadipay_app/screens/logins/models/login_model.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _login_formKey = GlobalKey<FormState>();

  String? userToken;

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
        final token = responseData['data']['token'] as String;
        setState(() {
          userToken = token;
        });
        print('Token : $userToken');
        _navigateToWebView();
        // Return the user token
        print(' Responses Data: $responseData');
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

  void _navigateToWebView() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebViewPage(userToken: userToken),
    ));
  }

  void loginUser() {
    Login(
        LogInModel(
            email: emailController.text, password: passwordController.text),
        context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
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
                                  validator: (value) {
                                    RegExp emailRegExp = RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'t be empty';
                                    } else if (!emailRegExp.hasMatch(value)) {
                                      return 'Enter a correct email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  isPassword: true,
                                  prefixIcon: Icon(Icons.lock_outline_sharp),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cant be empty';
                                    }
                                    return null;
                                  },
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
                          Navigator.pushNamed(context, appRoutes.forgot);
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
                            Navigator.pushNamed(context, appRoutes.register);
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

class WebViewPage extends StatelessWidget {
  final String? userToken;

  WebViewPage({required this.userToken});
  InAppWebViewController? _webViewController;
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
              'https://app.dadipay.co/android.php?login_token=$userToken',
            ),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/json',
            }),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
      ),
    );
  }
}
