import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:holup/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          child: const Text('Ubytovanie'),
          onPressed: () => Get.toNamed(Routes.ACCOMMODATION_FILTERING),
        ),
      ),
    );
  }
}
