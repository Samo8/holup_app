import 'package:get/get.dart';
import 'package:holup/app/connection/http_requests.dart';

import 'package:holup/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  Future<void> signUp({
    int convictedNumber,
    String password,
    String passwordRepeat,
  }) async {
    if (password.length < 6) {
      Get.snackbar(
        'Slabé heslo',
        'Zadané heslo musí mať aspoň 6 znakov',
      );
      return;
    }
    if (password != passwordRepeat) {
      Get.snackbar('Heslá sa nezhodujú', 'Zadané heslá sa musia zhodovať');
      return;
    }

    try {
      final response = await SpringDatabaseOperations.signUp(
        convictedNumber,
        password,
      );

      if (response.statusCode != 200) {
        Get.snackbar(
          'Registrácia neúspešná',
          'Nepodarilo sa zaregistrovať, skúste no neskôr prosim.',
        );
        return;
      }
      await Get.offAndToNamed(Routes.SIGN_IN);
      Get.snackbar(
        'Registrácia úspešná',
        'Registrácia úspešná, prihláste sa prosím',
      );
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Registrácia neúspešná',
        'Nepodarilo sa zaregistrovať, skúste no neskôr prosim.',
      );
    }
  }
}
