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
          padding: EdgeInsets.only(top: heightWidth * 0.05, left: screenWidth * 0.05, right: screenWidth * 0.05),
          child: Center(
              child: SfCalendar(
                        view: CalendarView.month,
                        showNavigationArrow: true,
                        showDatePickerButton: true,
                        headerStyle: CalendarHeaderStyle(
                            textStyle: TextStyle(
                              color: Color(0xff38B69A),
                              fontSize: 18,
                              fontFamily: "PoppinsSemiBold",
                            )),
                        viewHeaderStyle: ViewHeaderStyle(
                          backgroundColor: Color(0xff2B8D78),
                            dayTextStyle: TextStyle(
                                color: Color(0xffFDFFFE),
                            fontFamily: "PoppinsMedium")),
                        monthViewSettings: MonthViewSettings(
                            showAgenda: true,),),
            )
          ),
        ),
      );
  }
}
