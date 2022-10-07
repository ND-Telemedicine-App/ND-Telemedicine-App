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

  Future<List> getDoctors() async {
    Response res = await get(Uri.parse("http://localhost:8080/user/doctors"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      return obj;
    } else {
      throw "Unable to retrieve doctors data.";
    }
  }

  Future<List> getPatients() async {
    Response res = await get(Uri.parse("http://localhost:8080/user/patients"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      return obj;
    } else {
      throw "Unable to retrieve patients data.";
    }
  }

  Future<List> getAppointments() async {
    var api = 'http://localhost:8090/appointment/all';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  @override
  void initState() {
    super.initState();
    getData("http://localhost:8080/user/doctors");
    getData("http://localhost:8080/user/patients");
    getData('http://localhost:8090/appointment/all');
    //getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PageTitle(title: "Dashboard"),
            FutureBuilder<List>(
              future: getData("http://localhost:8080/user/doctors"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.length.toString());
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      )
    );
  }
}