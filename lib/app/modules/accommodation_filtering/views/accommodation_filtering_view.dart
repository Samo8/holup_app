import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/accommodation_filtering_controller.dart';

class AccommodationFilteringView
    extends GetView<AccommodationFilteringController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccommodationFilteringView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AccommodationFilteringView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
