import 'package:flutter/material.dart';
import 'package:holup/app/models/automatic_event_item.dart';

enum AutomaticEventType { RESOCIAL, WORK_OFFICE }

class AutomaticEvent {
  final String title;
  final AutomaticEventType type;
  final List<AutomaticEventItem> items;

  const AutomaticEvent({
    @required this.title,
    @required this.type,
    @required this.items,
  });

  const AutomaticEvent.empty()
      : title = '',
        type = AutomaticEventType.RESOCIAL,
        items = const [];
}
