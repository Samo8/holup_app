import 'package:googleapis/calendar/v3.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({List<Event> events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final Event event = appointments[index];
    print('start date: ${event.start.date}');
    print('start date time: ${event.start?.dateTime?.toLocal()}');
    // return event.start.date ?? event.start.dateTime.toLocal();
    return event.start?.dateTime?.toLocal() ?? event.start?.date?.toLocal();
  }

  @override
  bool isAllDay(int index) {
    // return appointments[index].startTime.date != null;
    return appointments[index].start.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final Event event = appointments[index];
    return event.end?.dateTime?.toLocal() ?? event.end?.date?.toLocal();
    // return event.endTimeUnspecified != null && event.endTimeUnspecified
    //     ? (event.start.date ?? event.start.dateTime.toLocal())
    //     : (event.end.date != null
    //         ? event.end.date.add(Duration(days: -1))
    //         : event.end.dateTime.toLocal());
  }

  @override
  String getLocation(int index) {
    return appointments[index].location;
  }

  @override
  String getNotes(int index) {
    return appointments[index].description;
  }

  @override
  String getSubject(int index) {
    final Event event = appointments[index];

    // print('${event.summary} - ${event.start?.dateTime}');
    return event.summary == null || event.summary.isEmpty
        ? 'Bez názvu'
        : event.summary;
  }
}
