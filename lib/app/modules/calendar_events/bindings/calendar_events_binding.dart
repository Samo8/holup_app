import 'package:get/get.dart';

import '../controllers/calendar_events_controller.dart';

class CalendarEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarEventsController>(
      () => CalendarEventsController(),
    );
  }
}
