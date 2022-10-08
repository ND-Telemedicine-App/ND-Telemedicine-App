import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/api/get_api.dart';
import 'package:nd_telemedicine_app/screens/admin/admin_profile.dart';
import 'package:nd_telemedicine_app/screens/admin/appointments_screen.dart';
import 'package:nd_telemedicine_app/screens/admin/data_screen.dart';
import 'package:nd_telemedicine_app/screens/admin/patients_screen.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

import '../../services/models/user_model.dart';

import '../../widgets/global/globals.dart' as globals;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String doctorUri = "http://localhost:8080/user/doctors";
  String patientUri = "http://localhost:8080/user/patients";
  String appointmentUri = 'http://localhost:8090/appointment/all';

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
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
          //  App Bar
          Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminProfile(),),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                          AssetImage(currentUser?.avatar??""),
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome,",
                        style: TextStyle(
                            fontFamily: "PoppinsItalic", fontSize: 14),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        currentUser?.fullName??"",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PoppinsSemiBold",),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,MaterialPageRoute(builder: (context) => AdminProfile()),);
                      },
                      child: Icon(Icons.person_outline_rounded,
                          color: Colors.black))
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
              PageTitle(title: "Dashboard"),
              Text(
                "You can view the clinic's data here",
                style: TextStyle(
                  color: Color(0xff38b69a),
                  fontFamily: "PoppinsMedium",
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder<List>(
                future: getData(doctorUri),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDataScreen(data: snapshot.data!,
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            child: Container(
                              width: screenWidth * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              //margin: EdgeInsets.only(bottom: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffddfff8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    offset: Offset(
                                        0.5, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xff2b8d78),
                                        width: 10,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                                    child: Text(
                                      snapshot.data!.length.toString(),
                                      style: TextStyle(
                                          fontFamily: "PoppinsBold", fontSize: 40),
                                    ),
                                  ),
                                  Text(
                                    "Doctors",
                                    style: TextStyle(
                                      fontFamily: "PoppinsMedium",
                                      fontSize: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      )
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getData(patientUri),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDataScreen(data: snapshot.data!,
                                ),
                              ));
                        },
                        child: Column(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 10,
                              child: Container(
                                width: screenWidth * 0.7,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                //margin: EdgeInsets.only(bottom: 40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff38b69a),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      offset: Offset(
                                          0.5, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xff031011),
                                          width: 10,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                                      child: Text(
                                        snapshot.data!.length.toString(),
                                        style: TextStyle(
                                            fontFamily: "PoppinsBold",
                                            fontSize: 40,
                                            color: Color(0xfffdfffe),),
                                      ),
                                    ),
                                    Text(
                                      "Patients",
                                      style: TextStyle(
                                        fontFamily: "PoppinsMedium",
                                        color: Color(0xfffdfffe),
                                        fontSize: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        )
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getData(appointmentUri),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentDataScreen(data: snapshot.data!,
                                ),
                              ));
                        },
                        child: Column(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 10,
                              child: Container(
                                width: screenWidth * 0.7,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                //margin: EdgeInsets.only(bottom: 40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffbe3050),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      offset: Offset(
                                          0.5, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xffddfff8),
                                          width: 10,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                                      child: Text(
                                        snapshot.data!.length.toString(),
                                        style: TextStyle(
                                          fontFamily: "PoppinsBold",
                                          fontSize: 40,
                                          color: Color(0xfffdfffe),),
                                      ),
                                    ),
                                    Text(
                                      "Appointments",
                                      style: TextStyle(
                                        fontFamily: "PoppinsMedium",
                                        color: Color(0xfffdfffe),
                                        fontSize: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        )
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
