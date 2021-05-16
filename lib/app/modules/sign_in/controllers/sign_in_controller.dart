import 'dart:convert';

import 'package:get/get.dart';
import 'package:holup/app/connection/http_requests.dart';
import 'package:holup/app/controllers/api_controller.dart';
import 'package:holup/app/routes/app_pages.dart';

class SignInController extends GetxController {
  Future<void> signIn(int convictedNumber, String password) async {
    convictedNumber = 100;
    password = '123456';
    try {
      final response =
          await FlaskDatabaseOperations.signIn(convictedNumber, password);

      if (response.statusCode != 200) {
        Get.snackbar('Chyba', 'Nastala chyba pri prihlasovani');
        return;
      }
      final data = json.decode(response.body);

      final apiController = Get.find<ApiController>();
      apiController.apiKey.value = data['apiKey'];
      apiController.uuid.value = data['id'];

      await Get.offAndToNamed(Routes.CALENDAR_EVENTS);
    } catch (e) {
      print(e.toString());
    }
  }
}
