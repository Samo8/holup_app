import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent {
  final int id;
  final String userId;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final bool imported;

  const CalendarEvent({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.imported,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);
}
