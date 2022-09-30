import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nd_telemedicine_app/models/appointment.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

import '../models/busyTime.dart';

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

//fetch busy time data from database using API
Future<List<BusyTime>> getBusyTimes(http.Client client, int doctorId)async{
  final response = await client.get(Uri.parse("http://10.0.2.2:8080/busyTime/$doctorId"));

  return compute(parseBusyTime, response.body);
}

List<BusyTime> parseBusyTime(String response){
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed
      .map<BusyTime>((json) => BusyTime.fromJson(json))
      .toList();
}

//convert to Timeslot data source
Future<TimeslotDataSource> _getDataSource() async {
  final List<TimeSlot> slots = <TimeSlot>[];
  final DateTime today = DateTime.now();

  var busyTimes = await getBusyTimes(http.Client(), 1);

  final dateFormat = DateFormat("dd-MM-yy HH:mm");

  for(var i=0; i<busyTimes.length; i++){
    DateTime startTime = dateFormat.parse(busyTimes[i].getStartTime());
    slots.add(TimeSlot('Busy',
        startTime,
        startTime.add(Duration(hours: busyTimes[i].getDuration())),
        const Color(0xFFEFCCD4)));
  }

  final DateTime start3 =
  DateTime(today.year, today.month, today.day + 1, 15, 0, 0);
  slots.add(TimeSlot('Patient Baek Dohwa', start3,
      start3.add(const Duration(minutes: 30)), const Color(0xFF78CEBB)));
  return TimeslotDataSource(slots);
}

class _DoctorScheduleState extends State<DoctorSchedule>{
  late Future<TimeslotDataSource> timeslotDataSource;
  // get busyTimeLists of a doctor
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: FutureBuilder <TimeslotDataSource>(
            future: _getDataSource(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) {
                  return Center(
                      child: Text("${snapshot.error} occurred!",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20),
                      )
                    );
                  }else if(snapshot.hasData){
                  return DoctorSchedulePage(timeslotDataSource: snapshot.data!);
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
                },
          ),
        )
    );
  }
}

class DoctorSchedulePage extends StatelessWidget{
  const DoctorSchedulePage({Key? key, required this.timeslotDataSource}):super(key: key);

  final TimeslotDataSource timeslotDataSource;
    @override
    Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double heightWidth = MediaQuery.of(context).size.height;

      _showAddDialog() async {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Add Busy Time', style: TextStyle(
              fontFamily: "PoppinsSemiBold",
            ),),
            content: Text("Choose a time"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel', style: TextStyle(
                    fontFamily: "PoppinsMedium",
                    fontSize: 16),),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Save'),
                child: const Text('Save', style: TextStyle(
                    fontFamily: "PoppinsMedium",
                    fontSize: 16),),
              ),
            ],
          ),
        );
      }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffFDFFFE),
            elevation: 0,
            title: Text(
              "Appointments",
              style: const TextStyle(
                  fontFamily: "PoppinsBold",
                  color: Color(0xff2B8D78),
                  fontSize: 30),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff2B8D78),
            onPressed: _showAddDialog,
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    top: heightWidth * 0.05,
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05),
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
                          color: Color(0xff031011), fontFamily: "PoppinsMedium"),
                    ),
                    monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      agendaItemHeight: 60,
                      agendaStyle: AgendaStyle(
                        appointmentTextStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xff031011),
                          fontFamily: "PoppinsRegular",
                        ),
                        dateTextStyle: TextStyle(
                            color: Color(0xff031011),
                            fontSize: 20,
                            fontFamily: "PoppinsItalic"),
                        dayTextStyle: TextStyle(
                          color: Color(0xff031011),
                          fontSize: 20,
                          fontFamily: "PoppinsSemiBold",
                        ),
                      ),
                    ),
                    dataSource: timeslotDataSource,
                  ),
                )),
          ),
        );
  }

}
