import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/api_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/menu_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final apiController = Get.find<ApiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuItem(
              title: 'Ubytovanie',
              imagePath: 'assets/images/accommodation_menu.png',
              onTap: () => Get.toNamed(Routes.ACCOMMODATION_FILTERING),
            ),
            const SizedBox(height: 60),
            MenuItem(
              title: 'Kalendár',
              imagePath: 'assets/images/calendar_menu.png',
              onTap: () async => apiController.apiKey.isNotEmpty
                  ? await Get.toNamed(Routes.CALENDAR_EVENTS)
                  : await Get.toNamed(Routes.SIGN_IN),
            ),
          ],
        ),
      ),
    );
  }
}
