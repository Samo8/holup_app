import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/accommodation_list_controller.dart';

class AccommodationListView extends GetView<AccommodationListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccommodationListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AccommodationListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
