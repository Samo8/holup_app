import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/accommodation_detail_controller.dart';

class AccommodationDetailView extends GetView<AccommodationDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccommodationDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AccommodationDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
