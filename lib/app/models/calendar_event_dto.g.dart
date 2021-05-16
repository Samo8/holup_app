// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventDTO _$CalendarEventDTOFromJson(Map<String, dynamic> json) {
  return CalendarEventDTO(
    title: json['title'] as String,
    description: json['description'] as String,
    start: json['start'] as String,
    end: json['end'] as String,
  );
}

Map<String, dynamic> _$CalendarEventDTOToJson(CalendarEventDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'start': instance.start,
      'end': instance.end,
    };
