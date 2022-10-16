import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nd_telemedicine_app/models/appointment.dart';
import 'package:nd_telemedicine_app/services/models/appointment_model.dart';
import 'package:nd_telemedicine_app/services/models/user_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:duration_picker/duration_picker.dart';

import '../models/busyTime.dart';
import '../widgets/global/globals.dart' as globals;

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
      await client.get(Uri.parse("https://telemedicine-user-service.herokuapp.com/busyTime/$doctorId"));

  return compute(parseBusyTime, response.body);
}

List<BusyTime> parseBusyTime(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed.map<BusyTime>((json) => BusyTime.fromJson(json)).toList();
}

//fetch appointment with a doctor data from database using API
Future<List<AppointmentModel>> getAppointmentModel(
    http.Client client, int doctorId) async {
  final response = await client
      .get(Uri.parse("https://tele-appointment-service.herokuapp.com/appointment/doctor/$doctorId"));

  return compute(parseAppointmentModel, response.body);
}

//parse appointment data from json to list
List<AppointmentModel> parseAppointmentModel(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed
      .map<AppointmentModel>((json) => AppointmentModel.fromJson(json))
      .toList();
}

//fetch userinfo data from database using API
Future<List<User>> getUser(http.Client client) async {
  final response =
      await client.get(Uri.parse("https://telemedicine-user-service.herokuapp.com/user/patients"));

  return compute(parseUser, response.body);
}

//parse user data from json to list
List<User> parseUser(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

//find the patient by patientId
User findPatient(int patientId, List<User> patients) {
  for (int i = 0; i < patients.length; i++) {
    if (patients[i].getId() == patientId) {
      return patients[i];
    }
  }
  throw Exception("No patient");
}

//convert to Timeslot data source
Future<TimeslotDataSource> _getDataSource() async {
  final List<TimeSlot> slots = <TimeSlot>[];

  var busyTimes = await getBusyTimes(http.Client(), globals.currentUserId);
  var appointments = await getAppointmentModel(http.Client(), globals.currentUserId);
  var patients = await getUser(http.Client());

  final dateFormat = DateFormat("dd-MM-yy HH:mm");

  for (var i = 0; i < busyTimes.length; i++) {
    DateTime startTime = dateFormat.parse(busyTimes[i].getStartTime());
    slots.add(TimeSlot(
        'Busy',
        startTime,
        startTime.add(Duration(hours: busyTimes[i].getDuration())),
        const Color(0xFFEFCCD4)));
  }

  for (var i = 0; i < appointments.length; i++) {
    int? patientId = appointments[i].getPatientId();
    User patient = findPatient(patientId!, patients);
    DateTime startTime = dateFormat.parse(appointments[i].getStartTime()!);
    DateTime endTime = dateFormat.parse(appointments[i].getEndTime()!);
    slots.add(TimeSlot(
        "Appointment with ${patient.getFullname()!}", startTime, endTime, const Color(0xFF78CEBB)));
  }

  // final DateTime start3 =
  // DateTime(today.year, today.month, today.day + 1, 15, 0, 0);
  // slots.add(TimeSlot('Patient Baek Dohwa', start3,
  //     start3.add(const Duration(minutes: 30)), const Color(0xFF78CEBB)));
  return TimeslotDataSource(slots);
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  late Future<TimeslotDataSource> timeslotDataSource;
  final CalendarController _controller = CalendarController();
  final durationController = TextEditingController();

  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  String _dateSelected = "";
  Duration _duration = Duration(hours: 0, minutes: 0);

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
        print(_time.format(context));
      });
    }
  }

  void _selectDuration() async {
    var resultingDuration = await showDurationPicker(
      context: context,
      initialTime: Duration(minutes: 30),
    );
    if (resultingDuration != null) {
      setState(() {
        _duration = resultingDuration;
      });
    }
  }

  void selectionChanged(CalendarSelectionDetails details) {
    _dateSelected = DateFormat('dd-MM-yyyy').format(details.date!).toString();
    // print(_dateSelected);
  }

  _showAddDialog() async {
    // cannot select time if date is not selected
    // display alert to let user know
    if (_dateSelected == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "No date selected",
                style: TextStyle(fontFamily: "PoppinsSemiBold"),
              ),
              content: Text(
                  "You haven't selected your busy day yet. Please press on your desired date on the calendar to choose a day."),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                          fontFamily: "PoppinsSemiBold", fontSize: 16),
                    ))
              ],
            );
          });
      // display alert where user can choose a time
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            double screenWidth = MediaQuery.of(context).size.width;

            return AlertDialog(
              title: const Text(
                'Add Busy Time',
                style: TextStyle(
                  fontFamily: "PoppinsSemiBold",
                ),
              ),
              content:
                  StatefulBuilder(// You need this, notice the parameters below:
                      builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // button to go to timepicker
                    SizedBox(
                      width: screenWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          // display time picker
                          final TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: _time,
                            helpText: "CHOOSE YOUR BUSY TIME",
                          );
                          if (newTime != null) {
                            setState(() {
                              _time = newTime;
                              print(_time.format(context));
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: "PoppinsMedium")),
                        child: Text('SELECT TIME'),
                      ),
                    ),
                    // duration picker for choosing duration
                    SizedBox(
                      height: 20,
                    ),
                    Text(_time.format(context).toString(), style: TextStyle(fontFamily: "Clock", fontSize: 40),),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          var resultingDuration = await showDurationPicker(
                            context: context,
                            initialTime: Duration(minutes: 30),
                          );
                          if (resultingDuration != null) {
                            setState(() {
                              _duration = resultingDuration;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: "PoppinsMedium")),
                        child: Text('SELECT DURATION'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("${_duration.inHours}:${_duration.inMinutes%60}", style: TextStyle(fontFamily: "Clock", fontSize: 40),),
                  ],
                );
              }),
              actions: <Widget>[
                // Cancel btn
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 16),
                  ),
                ),
                // Save btn
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Save'),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 16),
                  ),
                ),
              ],
            );
          });
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
                          appointmentTextStyle:
                              TextStyle(fontFamily: "PoppinsRegular"),
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
