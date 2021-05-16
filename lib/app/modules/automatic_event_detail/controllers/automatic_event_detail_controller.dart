import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:holup/app/connection/http_requests.dart';
import 'package:holup/app/controllers/api_controller.dart';
import 'package:holup/app/models/automatic_event.dart';
import 'package:holup/app/models/calendar_event_dto.dart';
import 'package:holup/app/models/release.dart';
import 'package:holup/app/modules/automatic_events/controllers/automatic_events_controller.dart';
import 'package:holup/app/modules/calendar_events/controllers/calendar_events_controller.dart';
import 'package:intl/intl.dart';

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

  final apiController = Get.find<ApiController>();
  final calendarEventsController = Get.find<CalendarEventsController>();

  Future<void> addCalendarEventDialog(Widget dialog) async {
    await showDialog<void>(
      context: Get.context,
      builder: (ctx) => dialog,
    );
  }

  Future<Release> _fetchRelease(String uuid, String apiKey) async {
    final response = await FlaskDatabaseOperations.fetchReleaseDate(
      uuid,
      apiKey,
    );

    if (response.statusCode == 404) {
      throw 'Nebol nájdený dátum prepustenie';
    }
    if (response.statusCode != 200) {
      throw 'Nastala chyba';
    }

    final data = json.decode(response.body);
    return Release.fromJson(data);
  }

  Future<Event> _addEventToGoogleCalendar(
    CalendarEventDTO calendarEventDTO,
  ) async {
    final calendarId = await calendarEventsController.getZvjsCalendarId();

    final eventDate =
        calendarEventsController.allDayEvent(calendarEventDTO.end);

    print(calendarId);
    print(eventDate.toJson());

    final event = await calendarEventsController.addEvent(
      calendarId: calendarId,
      start: eventDate,
      end: eventDate,
      summary: '${calendarEventDTO.title} deadline',
      reminders: reminders,
    );
    calendarEventsController.googleCalendarEvents.add(event);
    return event;
  }

  int _calculateEventDeadline(AutomaticEventType type) {
    print(type);
    if (type == AutomaticEventType.RESOCIAL) {
      return 7;
    } else if (type == AutomaticEventType.WORK_OFFICE) {
      return 8;
    }
    return 0;
  }

  Future<void> addEventToCalendar(AutomaticEvent automaticEvent) async {
    try {
      final release = await _fetchRelease(
        apiController.uuid.value,
        apiController.apiKey.value,
      );

      final releaseDate = _dateFormat.parse(release.releaseDate);
      final eventDate = releaseDate.add(
        Duration(
          days: _calculateEventDeadline(automaticEvent.type),
        ),
      );

      final eventDateFormatted = _dateFormat.format(eventDate);

      final calendarEventDTO = CalendarEventDTO(
        title: automaticEvent.title,
        description: 'Posledný deň na vybavenie: ${automaticEvent.title}',
        start: eventDateFormatted,
        end: eventDateFormatted,
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
    } catch (e) {
      Get.back();
      print(e.toString());
    }
  }
}
