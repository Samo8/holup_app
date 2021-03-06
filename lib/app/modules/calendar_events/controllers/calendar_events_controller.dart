import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../connection/http_requests.dart';
import '../../../constants/constants.dart';
import '../../../controllers/api_controller.dart';
import '../../../models/calendar_event.dart';
import '../../../models/release.dart';
import '../../../routes/app_pages.dart';

enum Status { UNKNOWN, SUCCESS, FAILED, FETCHING }
enum DatePickerType { START, END }

class CalendarEventsController extends GetxController {
  static const zone = 'Europe/Bratislava';
  static const _releaseEventTitle = 'Prepustenie';

  final _dateTimeFormat = DateFormat('dd.MM.yyyy HH:mm');
  final _dateFormat = DateFormat('dd.MM.yyyy');

  final apiController = Get.find<ApiController>();

  final googleCalendarEvents = <Event>[].obs;

  final dateTimeStart = ''.obs;
  final dateTimeEnd = ''.obs;

  CalendarApi calendarAPI;
  var released = false;
  var status = Status.UNKNOWN.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      status.value = Status.FETCHING;
      await _initializeCalendarAPI();
      final events = await getGoogleEventsData();
      googleCalendarEvents.assignAll(events);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _addDatabaseEventsToCalendar(
    List<CalendarEvent> events,
    String calendarId,
  ) async {
    for (final event in events) {
      await addEvent(
        calendarId: calendarId,
        start: normalEvent(event.startTime),
        end: normalEvent(event.endTime),
        summary: event.title,
      );
      print(event.id);
      await SpringDatabaseOperations.updateCalendarEvent(
        event.id,
        apiController.apiKey.value,
      );
    }
  }

  Future<List<Event>> getGoogleEventsData() async {
    try {
      final zvjsCalendarId = await getHolupCalendarId();
      final dbCalendarEvents = await _fetchCalendarEvents();

      for (final x in dbCalendarEvents) {
        print(x.id);
      }

      if (dbCalendarEvents.isNotEmpty) {
        await _addDatabaseEventsToCalendar(dbCalendarEvents, zvjsCalendarId);
      }

      final calendarEvents = await calendarAPI.events.list(
        zvjsCalendarId,
        maxResults: 9999,
        singleEvents: true,
      );
      final appointments = <Event>[];
      if (calendarEvents != null && calendarEvents.items != null) {
        for (final event in calendarEvents.items) {
          if (event.start == null) {
            continue;
          }
          appointments.add(event);
        }
      }
      final releaseDateEvent =
          await _checkReleaseDate(appointments, zvjsCalendarId);

      final now = DateTime.now();

      if (now.isAfter(releaseDateEvent.start.date)) {
        released = true;
        final showDialog = await _showAutomaticEventsDialog();
        if (now.isBefore(now.add(Constants.automaticEventsImportMaxDuration)) &&
            showDialog &&
            !_alreadyContainsAllAutomaticEvents(appointments)) {
          Future.delayed(const Duration(seconds: 2), () async {
            await _importAutomaticEventsDialog();
          });
        }
      }
      status.value = Status.SUCCESS;
      return appointments;
    } catch (_) {
      status.value = Status.FAILED;
      rethrow;
    }
  }

  bool _alreadyContainsAllAutomaticEvents(List<Event> events) {
    final eventSummaries = events.map((event) => event.summary).toSet();
    final automaticEventsTitles = Constants.automaticEvents
        .map((event) => '${event.title} deadline')
        .toSet();

    print(eventSummaries.toString());
    print(automaticEventsTitles.toString());

    for (final event in automaticEventsTitles) {
      if (!eventSummaries.contains(event)) {
        return false;
      }
    }
    return true;
  }

  bool alreadyContainsEvent(String title) {
    final found = googleCalendarEvents
        .map((e) => e)
        .firstWhere((e) => e.summary == '$title deadline', orElse: () => null);
    return found == null ? false : true;
  }

  Future<void> _turnOffAutomaticEventsDialog() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showAutomaticEvents', false);
  }

  Future<bool> _showAutomaticEventsDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('showAutomaticEvents') ?? true;
  }

  Future<void> _importAutomaticEventsDialog() async {
    await showDialog(
      context: Get.context,
      builder: (_) {
        return AlertDialog(
          title: const Text('D??le??it?? udalosti'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Do V????ho kalend??ra je mo??n?? automaticky prida?? d??le??it?? udalosti ako '
                '??iados?? o resocializa??n?? pr??spevok alebo evidenciu na ??rade pr??ce',
              ),
              const SizedBox(height: 4.0),
              InkWell(
                child: const Text(
                  'Viac nezobrazova??',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () async {
                  await _turnOffAutomaticEventsDialog();
                  Get.back();
                },
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('Zisti?? viac'),
              onPressed: () => Get.offAndToNamed(Routes.AUTOMATIC_EVENTS),
            ),
            FlatButton(
              child: const Text('Nem??m z??ujem'),
              onPressed: () => Get.back(),
            ),
          ],
        );
      },
    );
  }

  EventDateTime allDayEvent(String date) {
    final dateTime = _dateFormat.parse(date);
    return EventDateTime()..date = dateTime;
  }

  EventDateTime normalEvent(String date) {
    final dateTime = _dateTimeFormat.parse(date);
    return EventDateTime()
      ..dateTime = dateTime
      ..timeZone = zone;
  }

  Future<Event> _checkReleaseDate(List<Event> events, String calendarId) async {
    final uuid = apiController.uuid.value;
    final apiKey = apiController.apiKey.value;

    final response =
        await SpringDatabaseOperations.fetchReleaseDate(uuid, apiKey);

    final data = json.decode(response.body);
    final releaseFromDB = Release.fromJson(data);

    if (response.statusCode != 200) {
      throw data['message'];
    }

    final releaseDateEvent = events
        .map((e) => e)
        .firstWhere((e) => e.summary == _releaseEventTitle, orElse: () => null);

    if (releaseDateEvent != null) {
      final releaseEventDate = releaseDateEvent.start.date;
      final releaseFromDBDate = _dateFormat.parse(releaseFromDB.releaseDate);

      if (!_compareDates(releaseEventDate, releaseFromDBDate)) {
        final addedEvent = await calendarAPI.events.update(
          releaseDateEvent
            ..start = allDayEvent(releaseFromDB.releaseDate)
            ..end = allDayEvent(releaseFromDB.releaseDate),
          calendarId,
          releaseDateEvent.id,
        );
        events.remove(releaseDateEvent);
        events.add(addedEvent);

        return addedEvent;
      }
      return releaseDateEvent;
    } else {
      final eventDateTime = allDayEvent(releaseFromDB.releaseDate);
      final event = await addEvent(
        calendarId: calendarId,
        start: eventDateTime,
        end: eventDateTime,
        summary: _releaseEventTitle,
      );
      events.add(event);
      return event;
    }
  }

  bool _compareDates(DateTime one, DateTime two) =>
      one.year == two.year && one.month == two.month && one.day == two.day
          ? true
          : false;

  Future<Event> addEvent({
    @required String calendarId,
    @required EventDateTime start,
    @required EventDateTime end,
    String summary,
    List<EventReminder> reminders = const [],
  }) async {
    final event = Event()
      ..start = start
      ..end = end
      ..summary = summary ?? '';

    if (reminders.isNotEmpty) {
      event.reminders = EventReminders()
        ..overrides = reminders
        ..useDefault = false;
    } else {
      event.reminders = EventReminders()..useDefault = true;
    }

    return await calendarAPI.events.insert(event, calendarId);
  }

  Future<String> getHolupCalendarId() async {
    try {
      final calendars = await calendarAPI.calendarList.list();
      final zvjsCalendar = calendars.items
          .map((item) => item)
          .firstWhere((item) => item.summary == 'Holup', orElse: () => null);
      if (zvjsCalendar == null) {
        final cal = await _insertHolupCalendar();
        return cal.id;
      }
      return zvjsCalendar.id;
    } catch (_) {
      rethrow;
    }
  }

  Future<Calendar> _insertHolupCalendar() async {
    return await calendarAPI.calendars.insert(
      Calendar()
        ..description = 'Kalend??r aplik??cie Holup'
        ..summary = 'Holup'
        ..timeZone = zone,
    );
  }

  Future<void> _initializeCalendarAPI() async {
    final httpClient = await clientViaUserConsent(
      ClientId(
        GetPlatform.isIOS
            ? env['ANDROID_GOOGLE_CLIENT_IDENTIFIER']
            : env['APPLE_GOOGLE_CLIENT_IDENTIFIER'],
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

  Future<void> showAlertDialog(Widget dialog) async {
    await showDialog<void>(
      context: Get.context,
      builder: (_) => dialog,
    );
  }

  Future<List<CalendarEvent>> _fetchCalendarEvents() async {
    try {
      final uuid = apiController.uuid.value;
      final apiKey = apiController.apiKey.value;
      final response =
          await SpringDatabaseOperations.fetchCalendarEvents(uuid, apiKey);
      if (response.statusCode != 200) {
        throw response.body;
      }
      final data = json.decode(response.body);

      final calendarEvents = (data as List)
          .map((event) => CalendarEvent.fromJson(event))
          .where((event) => !event.imported)
          .toList();

      return calendarEvents;
    } catch (_) {
      rethrow;
    }
  }

  String formatDate(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    return dateFormat.format(dateTime);
  }

  void initAddEventDates() {
    dateTimeStart.value = _dateTimeFormat.format(DateTime.now());
    dateTimeEnd.value = _dateTimeFormat.format(
      DateTime.now().add(const Duration(hours: 2)),
    );
  }
}
