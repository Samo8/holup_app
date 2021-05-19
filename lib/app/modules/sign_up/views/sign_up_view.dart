import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:holup/app/widgets/custom_textfield.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  final convictedNubmerController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrácia'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            hint: 'Číslo odsúdeného',
            controller: convictedNubmerController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          CustomTextField(
            hint: 'Heslo',
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscure: true,
          ),
          CustomTextField(
            hint: 'Heslo znovu',
            controller: passwordRepeatController,
            keyboardType: TextInputType.visiblePassword,
            obscure: true,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: Get.size.width / 2,
            height: Get.size.width / 2 * 0.19,
            child: ElevatedButton(
              child: const Text('Registrovať'),
              onPressed: () async => await controller.signUp(
                convictedNumber: int.tryParse(convictedNubmerController.text),
                password: passwordController.text,
                passwordRepeat: passwordRepeatController.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
