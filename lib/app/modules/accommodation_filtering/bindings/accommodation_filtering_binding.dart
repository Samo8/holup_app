import 'package:get/get.dart';

import '../controllers/accommodation_filtering_controller.dart';

class AccommodationFilteringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccommodationFilteringController>(
      () => AccommodationFilteringController(),
    );
  }
}
