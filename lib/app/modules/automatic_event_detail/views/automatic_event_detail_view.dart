import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:holup/app/constants/constants.dart';
import 'package:holup/app/models/automatic_event.dart';
import 'package:holup/app/modules/automatic_events/controllers/automatic_events_controller.dart';

import '../controllers/automatic_event_detail_controller.dart';

class AutomaticEventDetailView extends GetView<AutomaticEventDetailController> {
  final AutomaticEvent selectedEvent =
      Get.find<AutomaticEventsController>().selectedAutomaticEvent.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedEvent.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final automaticEventItem = selectedEvent.items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            automaticEventItem.title,
                            style: Get.textTheme.headline5,
                          ),
                          const SizedBox(height: 12.0),
                          Column(
                            children: automaticEventItem.content
                                .map(
                                  (itemContent) => RichText(
                                    text: TextSpan(
                                      text: '• ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: itemContent,
                                          style: Get.textTheme.bodyText2,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: selectedEvent.items.length,
            ),
          ),
          SafeArea(
            child: RaisedButton.icon(
              icon: Icon(Icons.add, color: Constants.primaryColor),
              label: const Text('Pridať udalosť'),
              onPressed: () async {
                await controller.addCalendarEventDialog(
                  AddEventAlertDialog(
                    automaticEvent: selectedEvent,
                    controller: controller,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddEventAlertDialog extends StatelessWidget {
  final AutomaticEvent automaticEvent;
  final AutomaticEventDetailController controller;

  const AddEventAlertDialog({this.automaticEvent, this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(automaticEvent.title),
      content: Text('Pridať udalosť: ${automaticEvent.title} do kalendára?'),
      actions: [
        FlatButton(
          child: const Text('Zrušiť'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('Pridať'),
          onPressed: () async =>
              await controller.addEventToCalendar(automaticEvent),
        ),
      ],
    );
  }
}
