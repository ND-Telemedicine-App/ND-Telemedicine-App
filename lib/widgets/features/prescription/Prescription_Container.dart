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
                        child: Text(prescriptions[index].doctorId.toString(),
                            style: TextStyle(fontSize: 26)),
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
