import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent {
  final int id;
  final int userId;
  final String name;
  final DateTime start;
  final DateTime end;
  final String text;
  final bool saved;

  const CalendarEvent({
    this.id,
    this.userId,
    this.name,
    this.start,
    this.end,
    this.text,
    this.saved,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);
}
