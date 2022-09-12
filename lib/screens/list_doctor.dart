import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20,),
                PageTitle(title: "Appointment"),
                  // search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      elevation: 10.0,
                      shadowColor: Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Find doctor...',
                          hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15),
                          prefixIcon: const Icon(Icons.search, color: Color(0xff38B69A),),
                          suffixIcon: Icon(Icons.filter_list_rounded, color: Color(0xff38B69A),),
                        ),
                      ),
                    ),
                  ),
            // doctor card
                SizedBox(height: 40,),
            Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              margin: EdgeInsets.only(bottom: 40),
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
                      image: AssetImage("assets/images/hansooyoung.jpg"),
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
                        child: Text(
                          "Dr. Han Sooyoung",
                          style: TextStyle(
                            color: Color(0xff78CEBB),
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text("Neurologist"),
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
              ],
            ),
          )
        ),
      );
  }
}
