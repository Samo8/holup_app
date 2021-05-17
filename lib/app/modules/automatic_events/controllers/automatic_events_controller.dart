import 'package:get/get.dart';

import '../../../models/automatic_event.dart';

class AutomaticEventsController extends GetxController {
  final selectedAutomaticEvent = AutomaticEvent.empty().obs;
  Function setState;
}
