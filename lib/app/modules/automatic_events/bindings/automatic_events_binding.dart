import 'package:get/get.dart';

import '../controllers/automatic_events_controller.dart';

class AutomaticEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AutomaticEventsController>(
      () => AutomaticEventsController(),
    );
  }
}
