import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/models/appointment.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DoctorSchedule extends StatefulWidget {
  const DoctorSchedule({Key? key}) : super(key: key);

  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}

class TimeslotDataSource extends CalendarDataSource {
  TimeslotDataSource(List<TimeSlot> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}


class _DoctorScheduleState extends State<DoctorSchedule> {

  List<TimeSlot> _getDataSource() {
    final List<TimeSlot> slots = <TimeSlot>[];
    final DateTime today = DateTime.now();

    final DateTime startTime =
    DateTime(today.year, today.month, today.day + 1, 9, 0, 0);
    final DateTime start2 =
    DateTime(today.year, today.month, today.day + 1, 13, 0, 0);
    final DateTime start3 =
    DateTime(today.year, today.month, today.day + 1, 15, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    slots.add(TimeSlot(
        'Busy', startTime, endTime, const Color(0xFFBE3050)));
    slots.add(TimeSlot(
        'Busy', start2, start2.add(const Duration(hours: 1)), const Color(0xFFBE3050)));
    slots.add(TimeSlot(
        'Patient Baek Dohwa', start3, start3.add(const Duration(minutes: 30)), const Color(0xFF2B8D78)));
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: heightWidth * 0.05, left: screenWidth * 0.05, right: screenWidth * 0.05),
          child: Center(
              child: SfCalendar(
                        view: CalendarView.month,
                        showNavigationArrow: true,
                        showDatePickerButton: true,
                        //cellBorderColor:  Color(0xff38b69a),
                        appointmentTextStyle: TextStyle(fontFamily: "PoppinsRegular"),
                        headerStyle: CalendarHeaderStyle(
                            textStyle: TextStyle(
                              color: Color(0xff2B8D78),
                              fontSize: 18,
                              fontFamily: "PoppinsSemiBold",
                            )),
                        viewHeaderStyle: ViewHeaderStyle(
                          backgroundColor: Color(0xffddfff8),
                            dayTextStyle: TextStyle(
                              color: Color(0xff031011),
                                fontFamily: "PoppinsMedium"),
                        ),
                        monthViewSettings: MonthViewSettings(
                            showAgenda: true,
                            agendaItemHeight: 60,
                            agendaStyle: AgendaStyle(
                              appointmentTextStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "PoppinsRegular",),
                              dateTextStyle: TextStyle(
                                  color: Color(0xff031011),
                                  fontSize: 20,
                                  fontFamily: "PoppinsItalic"),
                              dayTextStyle: TextStyle(
                                  color: Color(0xff031011),
                                  fontSize: 20,
                                  fontFamily: "PoppinsSemiBold",),
                            ),
                        ),
                        dataSource: TimeslotDataSource(_getDataSource()),
              ),
            )
          ),
        ),
      );
  }
}
