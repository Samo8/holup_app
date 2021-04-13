import 'package:get/get.dart';

import '../controllers/accommodation_list_controller.dart';

class AccommodationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccommodationListController>(
      () => AccommodationListController(),
    );
  }
}
