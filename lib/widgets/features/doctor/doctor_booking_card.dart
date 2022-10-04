import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/appointment.dart';
import 'package:nd_telemedicine_app/screens/chat_menu.dart';

class DoctorBookingCard extends StatelessWidget {
  final String doctorImagePath;
  final String doctorName;
  final String doctorSpeciality;
  final int doctorId;

  const DoctorBookingCard(
      {required this.doctorImagePath,
        required this.doctorName,
        required this.doctorSpeciality,
        required this.doctorId});

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
            //margin: EdgeInsets.only(bottom: 40),
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
                    image: AssetImage(doctorImagePath),
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
                          Text(
                            "Dr. $doctorName",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff78CEBB),
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 18,
                            ),
                          ),
                      ),
                    ),
                    Text(doctorSpeciality),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              minimumSize: Size(70, 35),
                            ),
                            onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppointmentScreen(doctorId: doctorId,)));
                            },
                            child: Text('BOOK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 14))),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 2, color: Color(0xff38B69A)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(70, 35),
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatMenu()),
                            );
                          },
                          child: Text('CHAT',
                            style: TextStyle(
                              color: Color(0xff38B69A),
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 14,),),),
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
