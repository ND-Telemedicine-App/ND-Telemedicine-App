import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../services/models/appointment_model.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  late List appointments;


  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceId: "15",
        userId: "16",
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 17, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));

    convertFutureListToList();
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<List> getAppointments() async {
    var api = 'http://localhost:8080/appointment/doctor/2';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  void convertFutureListToList() async {
    Future<List> futureOfList = getAppointments();
    appointments= await futureOfList ;
    for (dynamic appointment in appointments) {
      setState(() {
        converted.add(DateTimeRange(start: DateTime.parse(appointment["startTime"]), end: DateTime.parse(appointment["endTime"])));
      });

    }


    print(appointments);


  }


  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    AppointmentModel newAppointment = AppointmentModel(
        id: null,
        patientId: 1,
        doctorId: 2,
        startTime: newBooking.bookingStart.toString(),
        endTime: newBooking.bookingEnd.toString());
    // print('${newBooking.toJson()} has been uploaded');
    var body = json.encode(newAppointment.toJson());
    insertAppointment(body);
    print(body);
  }

  Future<AppointmentModel> insertAppointment(String body) async {
    const api = 'http://localhost:8080/createAppointment';
    var response = await http.post(Uri.parse(api),
        body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return AppointmentModel.fromJson(json.decode(response.body));
    }

    throw Exception("API noob");
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    print(streamResult);
    // for (dynamic appointment in appointments) {
    //   converted.add(DateTimeRange(start: DateTime.parse(appointment["startTime"]), end: DateTime.parse(appointment["endTime"])));
    // }

    print("Converted: ");
    print(converted);
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea (
          child:
            BookingCalendar(
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            bookedSlotColor: Color(0xffBE3050),
            availableSlotColor: Color(0xff38B69A),
            selectedSlotColor: Color(0xffDDFFF8),
            pauseSlots: generatePauseSlots(),
            pauseSlotText: 'Break',
            hideBreakTime: false,
            loadingWidget: const Text("Getting doctor's schedule..."),
            uploadingWidget: const CircularProgressIndicator(),
            locale: 'en_US',
            startingDayOfWeek: StartingDayOfWeek.monday,
        ),
      ),
    );
  }
}
