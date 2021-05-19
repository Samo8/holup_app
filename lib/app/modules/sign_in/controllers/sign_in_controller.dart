import 'dart:convert';

import 'package:get/get.dart';

import '../../../connection/http_requests.dart';
import '../../../controllers/api_controller.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  Future<void> signIn(int convictedNumber, String password) async {
    convictedNumber = 100;
    password = '123456';
    try {
      final response =
          await SpringDatabaseOperations.signIn(convictedNumber, password);

      if (response.statusCode != 200) {
        Get.snackbar(
          'Prihlásenie neúspešné',
          'Nepodarilo sa prihlásiť, skúste no neskôr prosim.',
        );
        return;
      }
      final data = json.decode(response.body);

      final apiController = Get.find<ApiController>();
      apiController.apiKey.value = data['apiKey'];
      apiController.uuid.value = data['id'];

      await Get.offAndToNamed(Routes.CALENDAR_EVENTS);
    } catch (_) {
      Get.snackbar(
        'Prihlásenie neúspešné',
        'Nepodarilo sa prihlásiť, skúste no neskôr prosim.',
      );
    }
  }
}
