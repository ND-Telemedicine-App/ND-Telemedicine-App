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
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<List<Appointment>> getAppointments(int doctorId) async {
    var api = 'http://localhost:8080/appointment/doctor/$doctorId';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      print(json);
      List<Appointment> appointments = <Appointment>[];

      for (int i = 0; i < json.length; i++) {
        Appointment appointment = Appointment.fromJson(json[i]);
        appointments.add(appointment);
      }

      return appointments;
    } else {
      throw "Cannot get appointment data";
    }
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    Appointment newAppointment = Appointment(
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

  Future<Appointment> insertAppointment(String body) async {
    const api = 'http://localhost:8080/createAppointment';
    var response = await http.post(Uri.parse(api),
        body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Appointment.fromJson(json.decode(response.body));
    }

    throw Exception("API noob");
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    DateTime first = now;
    DateTime second = now.add(const Duration(minutes: 30));
    DateTime third = now.subtract(const Duration(minutes: 90));
    DateTime fourth = now.add(const Duration(minutes: 240));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: now, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 15))));
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
