// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  const MyInputField(
      {Key? key,
      this.isPassword = false,
      this.hintText,
      this.keyboardType,
      this.onSaved,
      this.prefixIcon,
      this.label,
      this.controller})
      : super(key: key);

  final bool isPassword;
  final String? hintText;
  final TextInputType? keyboardType;

  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final String? label;

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  bool visiblePassword = false;

  @override
  void initState() {
    super.initState();
    visiblePassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: visiblePassword,
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      keyboardType: widget.keyboardType,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Error ';
        }
        return null;
      },
      onSaved: widget.onSaved,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          hintText: widget.hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          prefixIcon: widget.prefixIcon,
          labelText: widget.label,
          suffixIcon: widget.isPassword == false
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      visiblePassword = !visiblePassword;
                    });
                  },
                  icon: Icon(visiblePassword
                      ? Icons.visibility
                      : Icons.visibility_off))),
    );
  }
}
