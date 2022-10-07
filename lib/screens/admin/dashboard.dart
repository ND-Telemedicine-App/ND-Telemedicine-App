import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/api/get_api.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

}

class _DashboardScreenState extends State<DashboardScreen> {
  String doctorUri = "http://localhost:8080/user/doctors";
  String patientUri = "http://localhost:8080/user/patients";
  String appointmentUri = 'http://localhost:8090/appointment/all';

  late List doctors = [];
  late List patients = [];
  late List appointments = [];

  @override
  void initState() {
    super.initState();
    convertFutureListToList(doctorUri, doctors);
    convertFutureListToList(patientUri, patients);
    convertFutureListToList(appointmentUri, appointments);
  }

  void convertFutureListToList(String uri, List list) async {
    Future<List> futureOfList = getData(uri);
    list = await futureOfList ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              PageTitle(title: "Dashboard"),
              Text("View the clinic's data here"),
              Container(

              ),
              // FutureBuilder<List>(
              //   future: getData("http://localhost:8080/user/doctors"),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Text(snapshot.data!.length.toString());
              //     } else {
              //       return CircularProgressIndicator();
              //     }
              //   },
              // )
            ],
          ),
        ),
      )
    );
  }
}