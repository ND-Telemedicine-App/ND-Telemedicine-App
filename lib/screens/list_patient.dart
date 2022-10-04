import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/screens/doctor_profile.dart';
import 'package:nd_telemedicine_app/widgets/features/patient/patient_card.dart';

import '../widgets/features/page_title.dart';

class ALlPatientsScreen extends StatefulWidget {
  const ALlPatientsScreen({Key? key}) : super(key: key);

  @override
  State<ALlPatientsScreen> createState() =>
      _AllPatientsScreenState();
}

class _AllPatientsScreenState extends State<ALlPatientsScreen> {
  Future<List> getPatients() async {
    Response res = await get(Uri.parse("http://localhost:8080/user/patients"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      return obj;
    } else {
      throw "Unable to retrieve patients data.";
    }
  }

  @override
  void initState() {
    super.initState();
    getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                PageTitle(title: "Prescription"),
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
                        hintText: 'Find patient...',
                        hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xff38B69A),
                        ),
                        suffixIcon: Icon(
                          Icons.filter_list_rounded,
                          color: Color(0xff38B69A),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                FutureBuilder<List>(
                  future: getPatients(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorProfile(
                                        avatar: snapshot.data?[index]['avatar'],
                                        fullName: snapshot.data?[index]['fullName'],
                                        speciality: snapshot.data?[index]
                                        ['speciality'],
                                        email: snapshot.data?[index]['email'],
                                        address: snapshot.data?[index]['address'],
                                        phoneNumber: snapshot.data?[index]
                                        ['phoneNumber'],
                                        bio: snapshot.data?[index]['bio'],
                                      ),
                                    ));
                              },
                              child: PatientCard(
                                patientImagePath: snapshot.data?[index]['avatar'],
                                patientName: snapshot.data?[index]["fullName"],
                                patientStatus: snapshot.data?[index]
                                ["userStatus"],),
                            );
                          }
                        // },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}