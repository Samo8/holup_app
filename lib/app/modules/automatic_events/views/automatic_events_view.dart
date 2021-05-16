import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:holup/app/constants/constants.dart';
import 'package:holup/app/modules/calendar_events/controllers/calendar_events_controller.dart';
import 'package:holup/app/routes/app_pages.dart';

import '../controllers/automatic_events_controller.dart';

class AutomaticEventsView extends StatefulWidget {
  @override
  _AutomaticEventsViewState createState() => _AutomaticEventsViewState();
}

class _AutomaticEventsViewState extends State<AutomaticEventsView> {
  final controller = Get.put(AutomaticEventsController());
  final calendarEventsController = Get.find<CalendarEventsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dôležité udalosti'),
        centerTitle: true,
      ),
      body: GetBuilder<AutomaticEventsController>(
        builder: (_) => ListView.builder(
          itemBuilder: (ctx, index) {
            final event = Constants.automaticEvents[index];

            final alreadyImported =
                calendarEventsController.alreadyContainsEvent(event.title);

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Card(
                child: ListTile(
                  title: Text(event.title),
                  subtitle: Text(
                    alreadyImported
                        ? 'Udalosť už bola importovaná do kalendára'
                        : '',
                  ),
                  trailing: Icon(
                    Icons.help,
                    color:
                        alreadyImported ? Colors.grey : Constants.primaryColor,
                  ),
                  onTap: alreadyImported
                      ? null
                      : () {
                          controller.selectedAutomaticEvent.value = event;
                          controller.setState = () {
                            setState(() {});
                          };

                          Get.toNamed(Routes.AUTOMATIC_EVENT_DETAIL);
                        },
                ),
              ),
            );
          },
          itemCount: Constants.automaticEvents.length,
        ),
      ),
    );
  }
}
