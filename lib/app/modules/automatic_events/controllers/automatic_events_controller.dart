import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holup/app/models/automatic_event.dart';

class AutomaticEventsController extends GetxController {
  final selectedAutomaticEvent = AutomaticEvent.empty().obs;
  Function setState;
}
