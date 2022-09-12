import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/prescription_info.dart';

import '../../../models/prescription.dart';

class PrescriptionContainer extends StatelessWidget {
  const PrescriptionContainer({Key? key, required this.prescriptions})
      : super(key: key);

  final List<Prescription> prescriptions;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
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
        child: ListView.builder(
            itemCount: prescriptions.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                Text(prescriptions[0].medicineName),
              ]);
            }));
  }
}
