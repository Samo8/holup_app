import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';

import '../../../connection/http_requests.dart';
import '../../../controllers/api_controller.dart';
import '../../../models/automatic_event.dart';
import '../../../models/calendar_event_dto.dart';
import '../../../models/release.dart';
import '../../automatic_events/controllers/automatic_events_controller.dart';
import '../../calendar_events/controllers/calendar_events_controller.dart';

class AutomaticEventDetailController extends GetxController {
  final _dateFormat = DateFormat('dd.MM.yyyy');
  final reminders = [
    EventReminder()
      ..method = 'email'
      ..minutes = 9360,
    EventReminder()
      ..method = 'email'
      ..minutes = 6480,
    EventReminder()
      ..method = 'email'
      ..minutes = 3600,
    EventReminder()
      ..method = 'popup'
      ..minutes = 720,
    EventReminder()
      ..method = 'email'
      ..minutes = 720,
  ];

  final calendarEventsController = Get.find<CalendarEventsController>();

  Future<void> addCalendarEventDialog(Widget dialog) async {
    await showDialog<void>(
      context: Get.context,
      builder: (_) => dialog,
    );
  }

  Future<Release> _fetchRelease({String uuid, String apiKey}) async {
    final response = await SpringDatabaseOperations.fetchReleaseDate(
      uuid,
      apiKey,
    );

    if (response.statusCode == 404) {
      throw 'Nebol nájdený dátum prepustenia';
    }
    if (response.statusCode != 200) {
      throw 'Nastala chyba';
    }

    final Map<String, dynamic> data = json.decode(response.body);
    return Release.fromJson(data);
  }

  Future<void> _addEventToGoogleCalendar(
    CalendarEventDTO calendarEventDTO,
  ) async {
    final calendarId = await calendarEventsController.getZvjsCalendarId();
    final eventDate =
        calendarEventsController.allDayEvent(calendarEventDTO.end);

    final event = await calendarEventsController.addEvent(
      calendarId: calendarId,
      start: eventDate,
      end: eventDate,
      summary: '${calendarEventDTO.title} deadline',
      reminders: reminders,
    );
    calendarEventsController.googleCalendarEvents.add(event);
  }

  int _calculateEventDeadline({
    @required AutomaticEventType type,
    @required DateTime releaseDate,
  }) {
    if (type == AutomaticEventType.RESOCIAL) {
      return _calculateWorkingDays(releaseDate, 8);
    } else if (type == AutomaticEventType.WORK_OFFICE) {
      return 7;
    }
    return 0;
  }

  int _calculateWorkingDays(DateTime dateTime, int days) {
    for (var i = 0; i < days; i++) {
      dateTime = dateTime.add(const Duration(days: 1));
      if (dateTime.weekday == DateTime.saturday ||
          dateTime.weekday == DateTime.sunday) {
        days++;
      }
    }
    return days;
  }

  CalendarEventDTO _getCalendarEventDTO({
    AutomaticEvent automaticEvent,
    String eventDate,
  }) {
    return CalendarEventDTO(
      title: automaticEvent.title,
      description: 'Posledný deň na vybavenie: ${automaticEvent.title}',
      start: eventDate,
      end: eventDate,
    );
  }

  Future<void> addEventToCalendar(AutomaticEvent automaticEvent) async {
    try {
      calendarEventsController.status.value = Status.FETCHING;
      final apiController = Get.find<ApiController>();

      final release = await _fetchRelease(
        uuid: apiController.uuid.value,
        apiKey: apiController.apiKey.value,
      );
      final releaseDate = _dateFormat.parse(release.releaseDate);
      final eventDate = releaseDate.add(
        Duration(
          days: _calculateEventDeadline(
            type: automaticEvent.type,
            releaseDate: releaseDate,
          ),
        ),
      );
      final eventDateFormatted = _dateFormat.format(eventDate);

      final calendarEventDTO = _getCalendarEventDTO(
        automaticEvent: automaticEvent,
        eventDate: eventDateFormatted,
      );
      await _addEventToGoogleCalendar(calendarEventDTO);

      Get.find<AutomaticEventsController>().setState();
      Get.back();
      Get.back();

      Get.snackbar(
        'Udalosť uložená',
        'Udalosť bola úspešne uložená do kalendáru',
        duration: const Duration(seconds: 5),
      );
      calendarEventsController.status.value = Status.SUCCESS;
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Udalosť neblo uložená',
        'nepodarilo sa uložiť udalosť, skúste to neskôr prosím',
        duration: const Duration(seconds: 5),
      );
    }
  }
}
