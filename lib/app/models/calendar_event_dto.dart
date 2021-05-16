import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_dto.g.dart';

@JsonSerializable()
class CalendarEventDTO {
  final String title;
  final String description;
  final String start;
  final String end;

  const CalendarEventDTO({
    @required this.title,
    @required this.description,
    @required this.start,
    @required this.end,
  });

  factory CalendarEventDTO.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventDTOToJson(this);
}
