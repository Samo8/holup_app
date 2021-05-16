import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:holup/app/widgets/custom_textfield.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  final convictedNubmerController = TextEditingController();
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
            hint: 'Číslo odsúdeného',
            controller: convictedNubmerController,
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
              int.tryParse(convictedNubmerController.text),
              passwordController.text,
            ),
          ),
        ],
      ),
    );
  }
}
