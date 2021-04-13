import 'package:get/get.dart';

import '../controllers/accommodation_detail_controller.dart';

class AccommodationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccommodationDetailController>(
      () => AccommodationDetailController(),
    );
  }
}
