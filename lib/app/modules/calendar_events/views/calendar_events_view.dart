import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:holup/app/models/google_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controllers/calendar_events_controller.dart';

class CalendarEventsView extends GetView<CalendarEventsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Udalosti'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Obx(
              () => controller.googleCalendarEvents.isEmpty
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: SfCalendar(
                        view: CalendarView.week,
                        dataSource: GoogleDataSource(
                          events: controller.googleCalendarEvents,
                        ),
                        monthViewSettings: MonthViewSettings(
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.appointment,
                        ),
                      ),
                    ),
            ),
            RaisedButton.icon(
              label: const Text(
                'Pridať udalosť',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async => await controller.showAlertDialog(
                CustomAlertDialog(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;

  CustomTextField({
    @required this.labelText,
    this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
        controller: textEditingController,
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final calendarController = Get.find<CalendarEventsController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ListBody(
        children: [
          CustomTextField(
            labelText: 'Názov',
            textEditingController:
                calendarController.eventTitleTextEditingController,
          ),
          CustomTextField(
            labelText: 'Začiatok',
          ),
          CustomTextField(
            labelText: 'Koniec',
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: const Text('Zrušiť'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('Pridať'),
          onPressed: () async {
            try {
              print(await calendarController.addEvent());
            } catch (e) {
              print(e.toString());
            }
          },
        ),
      ],
    );
  }
}
