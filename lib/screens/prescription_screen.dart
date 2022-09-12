import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/Prescription_Container.dart';
import 'package:http/http.dart' as http;

import '../models/prescription.dart';

Future<Prescription> fetchPrescription() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8080/prescription/1'));

  if (response.statusCode == 200) {
    return Prescription.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load prescription');
  }
}

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  late Future<Prescription> futurePrescription;

  @override
  void initState() {
    super.initState();
    futurePrescription = fetchPrescription();
  }

  @override
  Widget build(BuildContext context) {
    double heightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: heightWidth * 0.1),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  // profile heading
                  PageTitle(title: "Prescription"),
                  FutureBuilder<Prescription>(
                      future: futurePrescription,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return PrescriptionContainer(
                              number: 1,
                              drugName: snapshot.data!.medicineName,
                              usage: snapshot.data!.dosageInstructions,
                              dispense: snapshot.data!.dispenseAmount,
                              refill: snapshot.data!.medicineRefill,
                              date: "13/03/2021",
                              doctor: "Choi Beomgyu");
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      }),
                  PrescriptionContainer(
                      number: 2,
                      drugName: "PH liquid med",
                      usage: "20ml before bed",
                      dispense: "2 bottles, 250ml each",
                      refill: "1",
                      date: "30/12/2021",
                      doctor: "Go Junho"),
                  PrescriptionContainer(
                      number: 3,
                      drugName: "ORV",
                      usage: "2 pills per day - take after lunch",
                      dispense: "1 bottle - 60 pills",
                      refill: "None",
                      date: "01/04/2021",
                      doctor: "Han Sooyoung"),
                ]))));
  }
}
