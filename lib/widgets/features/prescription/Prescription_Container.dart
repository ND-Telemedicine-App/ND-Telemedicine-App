import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/prescription_info.dart';

class PrescriptionContainer extends StatelessWidget {
  const PrescriptionContainer({
    Key? key,
    required this.number,
    required this.drugName,
    required this.usage,
    required this.dispense,
    required this.refill,
    required this.date,
    required this.signature
  }) : super(key:key);

  final int number;
  final String drugName;
  final String usage;
  final String dispense;
  final String refill;
  final String date;
  final String signature;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.only(top: 15, bottom: 20, left: 25, right: 25),
        width: screenWidth * 0.8,
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
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child:
            ExpansionTile(
              iconColor: Color(0xff78CEBB),
              title: Text("Prescription $number",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xff78CEBB)
                  )),

              children: [
                Column(
                  crossAxisAlignment :CrossAxisAlignment.stretch,
                  children: <Widget> [
                    PrescriptionInfo(infoHeader: "Rx", infoContent: drugName),
                    PrescriptionInfo(infoHeader: "Sig", infoContent: usage),
                    PrescriptionInfo(infoHeader: "Disp", infoContent: dispense),
                    PrescriptionInfo(infoHeader: "Rf", infoContent: refill),
                  ],

                ),
              ],
            ),
          ),
        )
    );
  }
}