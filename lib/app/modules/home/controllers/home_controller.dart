import 'package:get/get.dart';
import 'package:holup/app/constants/constants.dart';
import 'package:holup/app/models/automatic_event.dart';

class HomeController extends GetxController {
  final automaticEvent = AutomaticEvent(
    title: '',
    items: [],
  ).obs;
}
