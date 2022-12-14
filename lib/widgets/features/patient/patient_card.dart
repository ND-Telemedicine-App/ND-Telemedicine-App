import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/add_prescription.dart';
import 'package:nd_telemedicine_app/screens/chat_menu.dart';

class PatientCard extends StatelessWidget {
  final String patientImagePath;
  final String patientName;
  final String patientStatus;
  final int patientId;

  const PatientCard(
      {required this.patientImagePath,
        required this.patientName,
        required this.patientStatus,
        required this.patientId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: Container(
            width: screenWidth * 0.9,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(patientImagePath),
                    height: 120,
                    width: 120,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Container(
                        width: 150,
                        child:
                        Text(patientName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff78CEBB),
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Text(patientStatus, style: TextStyle(fontStyle: FontStyle.italic),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 170,
                          margin: const EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xff38B69A),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => AddPrescriptionScreen(patientId: patientId,)
                              ));
                            },
                            child: Center(
                            child: Text(
                              "PRESCRIBE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 14),
                            ),
                          ),
                          )
                        ),
                        Container(
                          width: 170,
                          margin: const EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color(0xff38B69A), width: 3)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatMenu()
                                  ));
                            },
                            child: Center(
                              child: Text(
                                "CHAT",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 14),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }

}