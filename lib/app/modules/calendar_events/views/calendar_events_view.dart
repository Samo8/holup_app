import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../models/google_data_source.dart';
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
              () => controller.status.value == Status.FETCHING
                  ? CircularProgressIndicator()
                  : controller.status.value == Status.FAILED
                      ? Center(
                          child: const Text(
                            'Nastala chyba pri získavaní udalostí z Google '
                            'kalendára, skúste to neskôr prosím',
                          ),
                        )
                      : Expanded(
                          child: SfCalendar(
                            view: CalendarView.schedule,
                            dataSource: GoogleDataSource(
                              events: controller.googleCalendarEvents,
                            ),
                            monthViewSettings: MonthViewSettings(
                              appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.appointment,
                            ),
                            onTap: (_) async {
                              await launch(
                                GetPlatform.isIOS
                                    ? 'calshow://'
                                    : 'content://com.android.calendar/time/',
                              );
                            },
                          ),
                        ),
            ),
            SafeArea(
              child: ElevatedButton.icon(
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
                  CustomAlertDialog(controller),
                ),
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
  final CalendarEventsController calendarController;

  const CustomAlertDialog(this.calendarController);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      ),
      actions: [
        FlatButton(
          child: const Text(
            'Zrušiť',
            style: TextStyle(color: Constants.primaryColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text(
            'Pridať',
            style: TextStyle(color: Constants.primaryColor),
          ),
          onPressed: () async {
            try {
              // print(await calendarController.addEvent());
            } catch (e) {
              print(e.toString());
            }
          },
        ),
      ],
    );
  }
}
