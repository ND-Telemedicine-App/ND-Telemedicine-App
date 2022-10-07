import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/api/get_api.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

}

class _DashboardScreenState extends State<DashboardScreen> {
  String doctorUri = "http://localhost:8080/user/doctors";
  String patientUri = "http://localhost:8080/user/patients";
  String appointmentUri = 'http://localhost:8090/appointment/all';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              PageTitle(title: "Dashboard"),
              Text("You can view the clinic's data here", style: TextStyle(
                color: Color(0xff38b69a),
                fontFamily: "PoppinsMedium",
                fontSize: 16,
              ),),
              SizedBox(height: 30,),
              FutureBuilder<List>(
                future: getData(doctorUri),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          child: Container(
                            width: screenWidth * 0.7,
                            padding: EdgeInsets.all(10),
                            //margin: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffddfff8),
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
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xff2b8d78),
                                        width: 10,
                                      ),
                                  ),
                                  padding: EdgeInsets.all(30),
                                  child: Text(
                                    snapshot.data!.length.toString(),
                                    style: TextStyle(
                                      fontFamily: "PoppinsBold",
                                      fontSize: 40
                                    ),
                                  ),
                                ),
                                Text("Doctors", style: TextStyle(
                                    fontFamily: "PoppinsMedium",
                                    fontSize: 25,
                                ),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getData(patientUri),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          child: Container(
                            width: screenWidth * 0.7,
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
                                Text(snapshot.data!.length.toString()),
                                Text("patients")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getData(appointmentUri),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          child: Container(
                            width: screenWidth * 0.7,
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
                                Text(snapshot.data!.length.toString()),
                                Text("appointments")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}