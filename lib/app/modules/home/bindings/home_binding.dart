import 'package:get/get.dart';
import 'package:holup/app/controllers/api_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiController(), permanent: true);
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
