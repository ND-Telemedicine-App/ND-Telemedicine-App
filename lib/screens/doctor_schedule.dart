import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DoctorSchedule extends StatefulWidget {
  const DoctorSchedule({Key? key}) : super(key: key);

  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: heightWidth * 0.05, horizontal: screenWidth * 0.05),
          child: Center(
            child: Column(
                  children: [
                    PageTitle(title: "Appointments"),
                    SfCalendar(view: CalendarView.month,),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
