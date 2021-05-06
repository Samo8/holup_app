import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:holup/app/widgets/custom_textfield.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prihlásenie'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            hint: 'Email',
            controller: emailController,
          ),
          CustomTextField(
            hint: 'Heslo',
            controller: passwordController,
            obscure: true,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            child: const Text('Prihlásiť'),
            onPressed: () async => await controller.signIn(
                emailController.text, passwordController.text),
          ),
        ],
      ),
    );
  }
}
