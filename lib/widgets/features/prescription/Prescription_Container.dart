import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/services/models/user_model.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/prescription_info.dart';
import 'package:http/http.dart' as http;

import '../../../models/prescription.dart';

Future<User> fetchDoctor(http.Client client, int doctorId) async {
  print('Doctor ID: $doctorId');
  final response =
      await client.get(Uri.parse('https://telemedicine-user-service.herokuapp.com/user/$doctorId'));

  // Use the compute function to run parseDoctor in a separate isolate.
  client.close();
  return compute(parseDoctor, response.body);
}

// A function that converts a response body into a User.
User parseDoctor(String responseBody) {
  if (responseBody.isNotEmpty) {
    return User.fromJson(jsonDecode(responseBody));
  } else {
    throw Exception('Failed to load doctor');
  }
}

class PrescriptionContainer extends StatelessWidget {
  const PrescriptionContainer({Key? key, required this.prescriptions})
      : super(key: key);

  final List<Prescription> prescriptions;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: prescriptions.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffFDFFFE),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 40,
                    offset: Offset(0.5, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ListTileTheme(
                contentPadding: EdgeInsets.all(0),
                dense: true,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Color(0xff78CEBB),
                    title: Center(
                      child: Text("Prescription #${index + 1}",
                          style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 20,
                              color: Color(0xff78CEBB))),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            PrescriptionInfo(
                                infoHeader: "Rx",
                                infoContent: prescriptions[index].medicineName),
                            PrescriptionInfo(
                                infoHeader: "Sig",
                                infoContent:
                                    prescriptions[index].dosageInstructions),
                            PrescriptionInfo(
                                infoHeader: "Disp",
                                infoContent:
                                    prescriptions[index].dispenseAmount),
                            PrescriptionInfo(
                                infoHeader: "Rf",
                                infoContent:
                                    prescriptions[index].medicineRefill),
                          ],
                        ),
                      ),
                      Text("Doctor's Signature",
                          style: TextStyle(
                            fontFamily: "PoppinsSemiBold",
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: FutureBuilder<User>(
                            future: fetchDoctor(
                                http.Client(), prescriptions[index].doctorId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data?.fullName ?? "",
                                    style: TextStyle(fontSize: 26));
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            }),
                      ),
                      Text(
                          "Date: ${prescriptions[index].prescriptionDate.split("-").reversed.join("-")}",
                          style: TextStyle(height: 3.5)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("Neighborhood Doctors Clinic"),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
