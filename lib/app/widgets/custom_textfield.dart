import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  final List<TextInputFormatter> inputFormatters;
  final bool obscure;

  CustomTextField({
    @required this.controller,
    @required this.keyboardType,
    @required this.hint,
    this.inputFormatters,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
        ),
        obscureText: obscure,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
