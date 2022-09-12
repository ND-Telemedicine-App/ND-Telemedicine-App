import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/doctor/doctor_booking_card.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20,),
                PageTitle(title: "Appointment"),
                  // search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      elevation: 10.0,
                      shadowColor: Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Find doctor...',
                          hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15),
                          prefixIcon: const Icon(Icons.search, color: Color(0xff38B69A),),
                          suffixIcon: Icon(Icons.filter_list_rounded, color: Color(0xff38B69A),),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 40,),
                DoctorBookingCard(doctorImagePath: "assets/images/hansooyoung.jpg", doctorName: "Han Sooyoung", doctorSpeciality: "Neurologist")
              ],
            ),
          )
        ),
      );
  }
}
