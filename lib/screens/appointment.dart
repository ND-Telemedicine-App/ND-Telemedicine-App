import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nd_telemedicine_app/api/get_api.dart';
import 'package:nd_telemedicine_app/screens/list_doctor.dart';

import '../models/busyTime.dart';
import '../services/models/appointment_model.dart';
import '../services/models/user_model.dart';

import '../widgets/global/globals.dart' as globals;

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key, required this.doctorId}) : super(key: key);

  final int doctorId;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  late List appointments;
  late List busyTimes;
  List<DateTimeRange> convertedBusyTime = [];
  final dateFormat = DateFormat("dd-MM-yy HH:mm");

  User? currentUser;
  bool isLoadingData = true;

  Future<Map<String, dynamic>> getCurrentUser() async {
    Response res = await get(
        Uri.parse("https://telemedicine-user-service.herokuapp.com/user/${globals.currentUserId}"));

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
    convertFutureBusyTimeList();
  }

  void convertFutureBusyTimeList() async {
    String busyTimeUri = 'https://telemedicine-user-service.herokuapp.com/busyTime/${widget.doctorId}';
    Future<List> futureOfList = getData(busyTimeUri);
    busyTimes= await futureOfList;

    for (dynamic busyTime in busyTimes) {
      DateTime startTime = dateFormat.parse(busyTime["busyTime"]);
      DateTime endTime = startTime.add(Duration(hours:busyTime["duration"]));
      setState(() {
        convertedBusyTime.add(DateTimeRange(start: startTime, end: endTime));
      });

    }
  }

  void convertFutureListToList() async {
    String appointmentUri = 'https://tele-appointment-service.herokuapp.com/appointment/doctor/${widget.doctorId}';
    Future<List> futureOfList = getData(appointmentUri);
    appointments= await futureOfList ;
    for (dynamic appointment in appointments) {
      setState(() {
        converted.add(DateTimeRange(start: dateFormat.parse(appointment["startTime"]), end: dateFormat.parse(appointment["endTime"])));
      });

    }
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    AppointmentModel newAppointment = AppointmentModel(
        id: null,
        patientId: currentUser?.id,
        doctorId: widget.doctorId,
        startTime: newBooking.bookingStart.toString(),
        endTime: newBooking.bookingEnd.toString());
    var body = json.encode(newAppointment.toJson());
    insertAppointment(body);
  }

  Future<AppointmentModel> insertAppointment(String body) async {
    const api = 'https://tele-appointment-service.herokuapp.com/createAppointment';
    var response = await http.post(Uri.parse(api),
        body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return AppointmentModel.fromJson(json.decode(response.body));
    }

    throw Exception("Cannot get data");
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
    return convertedBusyTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DoctorAppointmentScreen()));
          },
        ),
      centerTitle: true,
      title: Text(
        "Appointment",
        style: const TextStyle(fontFamily: "PoppinsBold"),
      ),
    ),
        body: SafeArea (
          child:
            Flex(
              direction: Axis.vertical,
              children: [Flexible(
                child: BookingCalendar(
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
                uploadingWidget: const Center(child: CircularProgressIndicator()),
                locale: 'en_US',
                startingDayOfWeek: StartingDayOfWeek.monday,
        ),
              ),]
            ),
      ),
    );
  }
}
