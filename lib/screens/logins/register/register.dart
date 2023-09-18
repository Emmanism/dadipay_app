// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:dadipay_app/routes/app_routes.dart';
import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
import 'package:dadipay_app/serviices/api_client.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/my_input_field.dart';
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

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _register_formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final ApiClient apiClient = ApiClient();
  final AppRoutes appRoutes = AppRoutes();
  final formResult = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    middleNameController.dispose();
    occupationController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  void registerUser() {
    apiClient.Register(
        RegisterModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            middleName: middleNameController.text,
            occupation: occupationController.text,
            fullName: fullNameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            userName: userNameController.text,
            password: passwordController.text,
            passwordConfirmation: passwordConfirmationController.text),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Theme(
                    data: ThemeData(primarySwatch: black),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          Form(
                            key: _register_formKey,
                            child: Column(
                              children: [
                                MyInputField(
                                  controller: firstNameController,
                                  hintText: 'Firstname',
                                  label: 'Firstname',
                                  prefixIcon: Icon(Icons.person_2_outlined),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: lastNameController,
                                  label: 'Lastname',
                                  hintText: 'Lastname',
                                  prefixIcon: Icon(Icons.person_2_outlined),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: middleNameController,
                                  label: 'Middlename',
                                  hintText: 'Middlename',
                                  prefixIcon: Icon(Icons.person_2_outlined),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: occupationController,
                                  label: 'Occupation',
                                  hintText: 'Occupation',
                                  prefixIcon: Icon(Icons.person_2_outlined),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: fullNameController,
                                  label: 'Fullname',
                                  hintText: 'Fullname',
                                  prefixIcon: Icon(Icons.person_2_outlined),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: emailController,
                                  label: 'Email',
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
                                  controller: phoneNumberController,
                                  label: 'Phone Number',
                                  hintText: ' Enter Phone Number',
                                  prefixIcon: Icon(Icons.phone),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: userNameController,
                                  label: 'Username',
                                  hintText: 'Unique Username',
                                  prefixIcon: Icon(Icons.person_2_outlined),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: passwordController,
                                  label: 'Password',
                                  hintText: ' Create a Strong Password',
                                  isPassword: true,
                                  prefixIcon: Icon(Icons.lock_outline_sharp),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                MyInputField(
                                  controller: passwordConfirmationController,
                                  label: 'Comfirm Password',
                                  hintText: ' Comfirm Password',
                                  isPassword: true,
                                  prefixIcon: Icon(Icons.lock_outline_sharp),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ButtonWidget(
                                  onPress: () {
                                    if (_register_formKey.currentState!
                                        .validate()) {
                                      registerUser();
                                    }
                                  },
                                  text: 'Register',
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 16, left: 8, right: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already  have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, appRoutes.login);
                            },
                            child: Text(
                              'Login Here',
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
      ),
    );
  }
}
