import 'package:googleapis/calendar/v3.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({List<Event> events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final Event event = appointments[index];
    return event.start?.dateTime?.toLocal() ?? event.start?.date?.toLocal();
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].start.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final Event event = appointments[index];
    return event.end?.dateTime?.toLocal() ?? event.end?.date?.toLocal();
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

    return event.summary == null || event.summary.isEmpty
        ? 'Bez názvu'
        : event.summary;
  }
}
