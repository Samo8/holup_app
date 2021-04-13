import 'package:get/get.dart';

import '../modules/accommodation_detail/bindings/accommodation_detail_binding.dart';
import '../modules/accommodation_detail/views/accommodation_detail_view.dart';
import '../modules/accommodation_filtering/bindings/accommodation_filtering_binding.dart';
import '../modules/accommodation_filtering/views/accommodation_filtering_view.dart';
import '../modules/accommodation_list/bindings/accommodation_list_binding.dart';
import '../modules/accommodation_list/views/accommodation_list_view.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOMMODATION_FILTERING,
      page: () => AccommodationFilteringView(),
      binding: AccommodationFilteringBinding(),
    ),
    GetPage(
      name: _Paths.ACCOMMODATION_LIST,
      page: () => AccommodationListView(),
      binding: AccommodationListBinding(),
    ),
    GetPage(
      name: _Paths.ACCOMMODATION_DETAIL,
      page: () => AccommodationDetailView(),
      binding: AccommodationDetailBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => CalendarView(),
      binding: CalendarBinding(),
    ),
  ];
}
