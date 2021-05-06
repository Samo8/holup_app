import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:holup/app/connection/http_requests.dart';
import 'package:holup/app/controllers/api_controller.dart';
import 'package:holup/app/models/calendar_event.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarEventsController extends GetxController {
  static const zone = 'Europe/Bratislava';

  CalendarApi calendarAPI;
  final googleCalendarEvents = <Event>[].obs;
  final eventTitleTextEditingController = TextEditingController();
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   clientId:
  //       '622049164322-o257bhn73suuignsradr4s1htdi2fldb.apps.googleusercontent.com',
  //   scopes: <String>[
  //     CalendarApi.CalendarScope,
  //   ],
  // );

  @override
  void onInit() async {
    super.onInit();
    try {
      await _initializeCalendarAPI();
      final events = await getGoogleEventsData();
      googleCalendarEvents.addAll(events);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _addDatabaseEventsToCalendar(
      List<CalendarEvent> events, String calendarId) async {
    for (final event in events) {
      await addEvent(
        calendarId: calendarId,
        start: event.startTime,
        end: event.endTime,
        summary: event.title,
      );
      await FlaskDatabaseOperations.updateCalendarEvent(event.id);
    }
  }

  Future<List<Event>> getGoogleEventsData() async {
    try {
      print('GET EVENTS');
      // final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      // print(googleUser.toString());
      // final httpClient = clientViaApiKey(googleUser.id);
      final zvjsCalendarId = await _getZvjsCalendarId();
      final dbCalendarEvents = await fetchCalendarEvents();

      for (final x in dbCalendarEvents) {
        print(x.id);
      }

      if (dbCalendarEvents.isNotEmpty) {
        await _addDatabaseEventsToCalendar(dbCalendarEvents, zvjsCalendarId);
      }

      final calEvents = await calendarAPI.events.list(
        zvjsCalendarId,
        maxResults: 9999,
        singleEvents: true,
      );
      final appointments = <Event>[];
      if (calEvents != null && calEvents.items != null) {
        for (final event in calEvents.items) {
          if (event.start == null) {
            continue;
          }
          appointments.add(event);
        }
      }
      return appointments;
    } catch (_) {
      rethrow;
    }
  }

  Future<Event> addEvent({
    @required String calendarId,
    @required String start,
    @required String end,
    String summary,
  }) async {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final startEvent = EventDateTime();
    startEvent.dateTime = dateFormat.parse(start);
    startEvent.timeZone = zone;

    final endEvent = EventDateTime();
    endEvent.dateTime = dateFormat.parse(end);
    endEvent.timeZone = zone;

    final event = Event()
      ..start = startEvent
      ..end = endEvent
      ..summary = summary ?? '';

    print(event.start);
    print(event.end);
    print(event.summary);

    return await calendarAPI.events.insert(event, calendarId);
  }

  Future<String> _getZvjsCalendarId() async {
    try {
      final calendars = await calendarAPI.calendarList.list();
      final zvjsCalendar = calendars.items
          .map((item) => item)
          .firstWhere((item) => item.summary == 'Holup', orElse: () => null);
      if (zvjsCalendar == null) {
        final cal = await _insertZVJSCalendar();
        return cal.id;
      }
      return zvjsCalendar.id;
    } catch (_) {
      rethrow;
    }
  }

  Future<Calendar> _insertZVJSCalendar() async {
    return await calendarAPI.calendars.insert(
      Calendar()
        ..description = 'Kalendár aplikácie Holup '
        ..summary = 'Holup'
        ..timeZone = zone,
    );
  }

  Future<void> _initializeCalendarAPI() async {
    final httpClient = await clientViaUserConsent(
      ClientId(
        '622049164322-o257bhn73suuignsradr4s1htdi2fldb.apps.googleusercontent.com',
        '',
      ),
      [CalendarApi.CalendarScope, 'email'],
      prompt,
    );
    calendarAPI = CalendarApi(httpClient);
  }

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> showAlertDialog(BuildContext context, Widget alertDialog) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => alertDialog,
    );
  }

  Future<List<CalendarEvent>> fetchCalendarEvents() async {
    try {
      final apiController = Get.find<ApiController>();
      final uuid = apiController.uuid.value;
      final apiKey = apiController.apiKey.value;
      final response =
          await FlaskDatabaseOperations.fetchCalendarEvents(uuid, apiKey);
      if (response.statusCode != 200) {
        throw response.body;
      }
      final data = json.decode(response.body);
      print(data);
      final calendarEvents = (data as List)
          .map((event) => CalendarEvent.fromJson(event))
          .where((event) => !event.imported)
          .toList();

      return calendarEvents;
    } catch (_) {
      rethrow;
    }
  }
}
