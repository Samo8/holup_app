import 'package:get/get.dart';

import '../../accommodation_filtering/controllers/accommodation_filtering_controller.dart';

class AccommodationListController extends GetxController {
  final accommodationFilteringController =
      Get.find<AccommodationFilteringController>();

  @override
  void onInit() async {
    super.onInit();
    await accommodationFilteringController.fetchAccommodations();
  }
}
