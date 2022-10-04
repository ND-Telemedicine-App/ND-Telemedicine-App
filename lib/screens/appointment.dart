import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../services/models/appointment_model.dart';
import '../services/models/user_model.dart';

import '../widgets/global/globals.dart' as globals;

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  late List appointments;

  User? currentUser;
  bool isLoadingData = true;

  Future<Map<String, dynamic>> getCurrentUser() async {
    Response res = await get(
        Uri.parse("http://localhost:8080/user/${globals.currentUserId}"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      User thisUser = User(
        id: obj['id'],
        role: obj['role'],
        email: obj['email'],
        password: obj['password'],
        fullName: obj['fullName'],
        avatar: obj['avatar'],
        address: obj['address'],
        phoneNumber: obj['phoneNumber'],
        gender: obj['gender'],
        dateOfBirth: obj['dateOfBirth'],
        allergies: obj['allergies'],
        diseases: obj['diseases'],
        medication: obj['medication'],
        bio: obj['bio'],
        speciality: obj['speciality'],
      );
      setState(() {
        currentUser = thisUser;
        isLoadingData = false;
      });
      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }


  @override
  void initState() {
    super.initState();
    getCurrentUser();
    mockBookingService = BookingService(
        serviceId: "15",
        userId: currentUser?.id.toString(),
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
    var api = 'http://localhost:8081/appointment/doctor/2';
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


  }


  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    Appointment newAppointment = Appointment(
        id: null,
        patientId: currentUser?.id,
        doctorId: 2,
        startTime: newBooking.bookingStart.toString(),
        endTime: newBooking.bookingEnd.toString());
    var body = json.encode(newAppointment.toJson());
    insertAppointment(body);
  }

  Future<Appointment> insertAppointment(String body) async {
    const api = 'http://localhost:8081/createAppointment';
    var response = await http.post(Uri.parse(api),
        body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Appointment.fromJson(json.decode(response.body));
    }

    throw Exception("API noob");
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
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
