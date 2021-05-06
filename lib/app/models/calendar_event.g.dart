// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) {
  return CalendarEvent(
    id: json['id'] as int,
    userId: json['userId'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    imported: json['imported'] as bool,
  );
}

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'imported': instance.imported,
    };
