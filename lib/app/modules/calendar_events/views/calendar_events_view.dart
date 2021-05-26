import 'package:date_time_picker/date_time_picker.dart';
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
              () => controller.googleCalendarEvents.isEmpty
                  ? CircularProgressIndicator()
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
            // Obx(
            //   () => controller.status.value == Status.FETCHING
            //       ? CircularProgressIndicator()
            //       : controller.status.value == Status.FAILED
            //           ? Center(
            //               child: const Text(
            //                 'Nastala chyba pri získavaní udalostí z Google '
            //                 'kalendára, skúste to neskôr prosím',
            //               ),
            //             )
            //           : Expanded(
            //               child: SfCalendar(
            //                 view: CalendarView.schedule,
            //                 dataSource: GoogleDataSource(
            //                   events: controller.googleCalendarEvents,
            //                 ),
            //                 monthViewSettings: MonthViewSettings(
            //                   appointmentDisplayMode:
            //                       MonthAppointmentDisplayMode.appointment,
            //                 ),
            //                 onTap: (_) async {
            //                   await launch(
            //                     GetPlatform.isIOS
            //                         ? 'calshow://'
            //                         : 'content://com.android.calendar/time/',
            //                   );
            //                 },
            //               ),
            //             ),
            // ),
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
                onPressed: () async {
                  controller.initAddEventDates();
                  await controller
                      .showAlertDialog(CustomAlertDialog(controller));
                },
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

  final eventTitleTextEditingController = TextEditingController();

  CustomAlertDialog(this.calendarController);

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
              textEditingController: eventTitleTextEditingController,
            ),
            const SizedBox(height: 12.0),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'dd.MM.yy HH:mm',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(DateTime.now().month - 1),
              lastDate: DateTime(DateTime.now().year + 2),
              icon: const Icon(Icons.event),
              dateLabelText: 'Začiatok',
              timeLabelText: 'Čas',
              onChanged: (val) => calendarController.dateTimeStart.value =
                  calendarController.formatDate(val),
              onSaved: (val) => calendarController.dateTimeStart.value =
                  calendarController.formatDate(val),
            ),
            const SizedBox(height: 12.0),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'dd.MM.yy HH:mm',
              initialValue:
                  DateTime.now().add(const Duration(hours: 2)).toString(),
              firstDate: DateTime(DateTime.now().month - 1),
              lastDate: DateTime(DateTime.now().year + 2),
              icon: const Icon(Icons.event),
              dateLabelText: 'Koniec',
              timeLabelText: 'Čas',
              onChanged: (val) => calendarController.dateTimeEnd.value =
                  calendarController.formatDate(val),
              onSaved: (val) => calendarController.dateTimeEnd.value =
                  calendarController.formatDate(val),
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
              final summary = eventTitleTextEditingController.text;
              if (summary.isEmpty) {
                Get.snackbar(
                  'Názov udalosti je prázdny',
                  'Názov udalosti nemôže byť prázdny',
                );
                return;
              }
              final calendarId = await calendarController.getHolupCalendarId();
              final start = calendarController
                  .normalEvent(calendarController.dateTimeStart.value);

              final end = calendarController
                  .normalEvent(calendarController.dateTimeEnd.value);

              final event = await calendarController.addEvent(
                calendarId: calendarId,
                start: start,
                end: end,
                summary: summary,
              );
              calendarController.googleCalendarEvents.add(event);
              Get.back();
            } catch (_) {
              Get.snackbar(
                'Chyba pri ukladaní udalosti',
                'Nastala chyba pri ukladaní udalosti, skúste to neskôr prosím',
              );
            }
          },
        ),
      ],
    );
  }
}
