import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/Prescription_Container.dart';
import 'package:http/http.dart' as http;

import '../models/prescription.dart';

Future<List<Prescription>> fetchPrescriptions(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://localhost:8080/prescription/patient/1111'));

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
                    return PrescriptionContainer(prescriptions: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
