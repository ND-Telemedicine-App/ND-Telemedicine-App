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
Future<List<BusyTime>> getBusyTimes(http.Client client, int doctorId) async {
  final response =
      await client.get(Uri.parse("http://localhost:8080/busyTime/$doctorId"));

  return compute(parseBusyTime, response.body);
}

List<BusyTime> parseBusyTime(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed.map<BusyTime>((json) => BusyTime.fromJson(json)).toList();
}

//convert to Timeslot data source
Future<TimeslotDataSource> _getDataSource() async {
  final List<TimeSlot> slots = <TimeSlot>[];
  final DateTime today = DateTime.now();

  var busyTimes = await getBusyTimes(http.Client(), 1);

  final dateFormat = DateFormat("dd-MM-yy HH:mm");

  for (var i = 0; i < busyTimes.length; i++) {
    DateTime startTime = dateFormat.parse(busyTimes[i].getStartTime());
    slots.add(TimeSlot(
        'Busy',
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

class _DoctorScheduleState extends State<DoctorSchedule> {
  late Future<TimeslotDataSource> timeslotDataSource;
  final CalendarController _controller = CalendarController();

  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  String _dateSelected = "";

  void _selectTime() async {
      // display time picker
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _time,
        helpText: "CHOOSE YOUR BUSY TIME",

      );
      if (newTime != null) {
        setState(() {
          _time = newTime;
        });

    }
  }

  void selectionChanged(CalendarSelectionDetails details) {
      _dateSelected = DateFormat('dd-MM-yy').format(details.date!).toString();
      print(_dateSelected);
  }

  _showAddDialog() async {
    // cannot select time if date is not selected
    // display alert to let user know
    if (_dateSelected == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("No date selected", style: TextStyle(fontFamily: "PoppinsSemiBold"),),
              content: Text("You haven't selected your busy day yet. Please press on your desired date on the calendar to choose a day."),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK', style: TextStyle(fontFamily: "PoppinsSemiBold", fontSize: 16),))
              ],
            );
          });
      // display alert where user can choose a time
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Add Busy Time', style: TextStyle(
                fontFamily: "PoppinsSemiBold",
              ),),
              content: ElevatedButton(
                onPressed: _selectTime,
                child: Text('SELECT TIME'),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textStyle: TextStyle(fontSize: 18, fontFamily: "PoppinsMedium")),
              ),
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
  }

  // get busyTimeLists of a doctor
  @override
  Widget build(BuildContext context) {
    double heightWidth = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<TimeslotDataSource>(
        future: _getDataSource(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "${snapshot.error} occurred!",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ));
            } else if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  toolbarHeight: 50,
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
                          controller: _controller,
                          onSelectionChanged: selectionChanged,
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
                          dataSource: snapshot.data!,
                        ),
                      )),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}

// class DoctorSchedulePage extends StatelessWidget {
//   DoctorSchedulePage(
//       {Key? key, required this.timeslotDataSource, required this.selectTime,})
//       : super(key: key);
//
//   final TimeslotDataSource timeslotDataSource;
//   final Function()? selectTime;
//   final CalendarController _controller = CalendarController();
//   // final Function(CalendarSelectionDetails)? selectionChanged;
//   // final String dateSelected;
//
//   set selectedDate(DateTime? date) {
//     dateSelected = date;
//     print(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double heightWidth = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         toolbarHeight: 50,
//         backgroundColor: Color(0xffFDFFFE),
//         elevation: 0,
//         title: Text(
//           "Appointments",
//           style: const TextStyle(
//               fontFamily: "PoppinsBold",
//               color: Color(0xff2B8D78),
//               fontSize: 30),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xff2B8D78),
//         onPressed: selectTime,
//         child: Icon(Icons.add),
//       ),
//       body: SafeArea(
//         child: Padding(
//             padding: EdgeInsets.only(
//                 top: heightWidth * 0.05,
//                 left: screenWidth * 0.05,
//                 right: screenWidth * 0.05),
//             child: Center(
//               child: SfCalendar(
//                 controller: _controller,
//                 //onSelectionChanged: selectionChanged,
//
//                 view: CalendarView.month,
//                 showNavigationArrow: true,
//                 showDatePickerButton: true,
//                 //cellBorderColor:  Color(0xff38b69a),
//                 appointmentTextStyle: TextStyle(fontFamily: "PoppinsRegular"),
//                 headerStyle: CalendarHeaderStyle(
//                     textStyle: TextStyle(
//                   color: Color(0xff2B8D78),
//                   fontSize: 18,
//                   fontFamily: "PoppinsSemiBold",
//                 )),
//                 viewHeaderStyle: ViewHeaderStyle(
//                   backgroundColor: Color(0xffddfff8),
//                   dayTextStyle: TextStyle(
//                       color: Color(0xff031011), fontFamily: "PoppinsMedium"),
//                 ),
//                 monthViewSettings: MonthViewSettings(
//                   showAgenda: true,
//                   agendaItemHeight: 60,
//                   agendaStyle: AgendaStyle(
//                     appointmentTextStyle: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xff031011),
//                       fontFamily: "PoppinsRegular",
//                     ),
//                     dateTextStyle: TextStyle(
//                         color: Color(0xff031011),
//                         fontSize: 20,
//                         fontFamily: "PoppinsItalic"),
//                     dayTextStyle: TextStyle(
//                       color: Color(0xff031011),
//                       fontSize: 20,
//                       fontFamily: "PoppinsSemiBold",
//                     ),
//                   ),
//                 ),
//                 dataSource: timeslotDataSource,
//               ),
//             )),
//       ),
//     );
//   }
// }
