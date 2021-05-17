import 'package:get/get.dart';

import '../modules/accommodation_detail/bindings/accommodation_detail_binding.dart';
import '../modules/accommodation_detail/views/accommodation_detail_view.dart';
import '../modules/accommodation_filtering/bindings/accommodation_filtering_binding.dart';
import '../modules/accommodation_filtering/views/accommodation_filtering_view.dart';
import '../modules/accommodation_list/bindings/accommodation_list_binding.dart';
import '../modules/accommodation_list/views/accommodation_list_view.dart';
import '../modules/automatic_event_detail/bindings/automatic_event_detail_binding.dart';
import '../modules/automatic_event_detail/views/automatic_event_detail_view.dart';
import '../modules/automatic_events/bindings/automatic_events_binding.dart';
import '../modules/automatic_events/views/automatic_events_view.dart';
import '../modules/calendar_events/bindings/calendar_events_binding.dart';
import '../modules/calendar_events/views/calendar_events_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';

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
      name: _Paths.CALENDAR_EVENTS,
      page: () => CalendarEventsView(),
      binding: CalendarEventsBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.AUTOMATIC_EVENT_DETAIL,
      page: () => AutomaticEventDetailView(),
      binding: AutomaticEventDetailBinding(),
    ),
    GetPage(
      name: _Paths.AUTOMATIC_EVENTS,
      page: () => AutomaticEventsView(),
      binding: AutomaticEventsBinding(),
    ),
  ];
}
