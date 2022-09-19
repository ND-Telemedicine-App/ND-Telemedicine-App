import 'package:flutter/material.dart';

class DoctorBookingCard extends StatelessWidget {
  final String doctorImagePath;
  final String doctorName;
  final String doctorSpeciality;

  const DoctorBookingCard(
      {required this.doctorImagePath,
        required this.doctorName,
        required this.doctorSpeciality});

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
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xff38B69A),
                          ),
                          child: const Center(
                            child: Text(
                              "BOOK",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color(0xff38B69A), width: 3)),
                          child: const Center(
                            child: Text(
                              "CHAT",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 14),
                            ),
                          ),
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