import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;

  CustomTextField({
    @required this.controller,
    @required this.hint,
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
      ),
    );
  }
}
