import 'package:get/get.dart';

import '../controllers/automatic_event_detail_controller.dart';

class AutomaticEventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AutomaticEventDetailController>(
      () => AutomaticEventDetailController(),
    );
  }
}
