import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/Prescription_Container.dart';
import 'package:http/http.dart' as http;

import '../models/prescription.dart';

Future<List<Prescription>> fetchPrescriptions(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://10.0.2.2:8080/prescription/patient/1111'));

  return compute(parsePrescriptions, response.body);
}

List<Prescription> parsePrescriptions(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<Prescription>((json) => Prescription.fromJson(json))
      .toList();
}

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  late Future<Prescription> futurePrescription;

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
                  FutureBuilder<List<Prescription>>(
                      future: fetchPrescriptions(http.Client()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return PrescriptionContainer(
                              prescriptions: snapshot.data!);
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error has occurred!'),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),

                  /*PrescriptionContainer(
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
                      doctor: "Han Sooyoung"),*/
                ]))));
  }
}

/*class PrescriptionsList extends StatelessWidget {
  const PrescriptionsList({super.key, required this.prescriptions});

  final List<Prescription> prescriptions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        return Text(prescriptions[index].medicineName);
      },
    );
  }
}*/
