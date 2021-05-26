import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:holup/app/routes/app_pages.dart';

import '../../../widgets/custom_textfield.dart';
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
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 12.0),
              const Text('Nemáte účet?'),
              InkWell(
                child: const Text(
                  'Zaregistujte sa tu',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () => Get.toNamed(Routes.SIGN_UP),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: Get.size.width / 2,
            height: Get.size.width / 2 * 0.19,
            child: ElevatedButton(
              child: const Text('Prihlásiť'),
              onPressed: () async => await controller.signIn(
                int.tryParse(convictedNubmerController.text),
                passwordController.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
