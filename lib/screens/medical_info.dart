import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/home.dart';
import 'package:nd_telemedicine_app/screens/personal_info.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine_app/screens/sign_in.dart';

import '../services/models/user_model.dart';

Future<User> createUser(
    String role,
    String email,
    String password,
    String fullName,
    String avatar,
    String address,
    String phoneNumber,
    String gender,
    String dateOfBirth,
    String allergies,
    String diseases,
    String medication) async {
  final response = await http.post(
    Uri.parse('https://telemedicine-user-service.herokuapp.com/createUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'role': role,
      'email': email,
      'password': password,
      'fullName': fullName,
      'avatar': avatar,
      'address': address,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'allergies': allergies,
      'diseases': diseases,
      'medication': medication,
    }),
  );

  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create User.');
  }
}

class MedicalInfo extends StatefulWidget {
  final String role;
  final String email;
  final String password;
  final String fullName;
  final String avatar;
  final String address;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;

  const MedicalInfo({
    Key? key,
    required this.role,
    required this.email,
    required this.password,
    required this.fullName,
    required this.avatar,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
  }) : super(key: key);

  @override
  State<MedicalInfo> createState() => _MedicalInfoState();
}

class _MedicalInfoState extends State<MedicalInfo> {
  String allergies = "";
  String diseases = "";
  String medication = "";

  bool isPushData = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/logo_cover.png",
                            fit: BoxFit.cover,
                            width: 400,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text("Medical Information",
                              style: TextStyle(
                                  color: Color(0xff2B8D78),
                                  fontSize: 25,
                                  fontFamily: 'PoppinsBold')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(children: <Widget>[
                        Container(
                          width: 350,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: const Text(
                            "Allergies",
                            style: TextStyle(
                                color: Color(0xff2B8D78),
                                fontSize: 15,
                                fontFamily: "PoppinsSemiBold"),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      allergies = value;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffEFF0F0),
                                      labelText: "Allergies (separated with ,)",
                                      labelStyle: TextStyle(fontSize: 13),
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, top: 15, bottom: 15),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                          width: 3,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 350,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: const Text(
                                    "Diseases",
                                    style: TextStyle(
                                        color: Color(0xff2B8D78),
                                        fontSize: 15,
                                        fontFamily: "PoppinsSemiBold"),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      diseases = value;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffEFF0F0),
                                      labelText: "Diseases (separated with ,)",
                                      labelStyle: TextStyle(fontSize: 13),
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, top: 15, bottom: 15),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                          width: 3,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 350,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: const Text(
                                    "Medication",
                                    style: TextStyle(
                                        color: Color(0xff2B8D78),
                                        fontSize: 15,
                                        fontFamily: "PoppinsSemiBold"),
                                  ),
                                ),
                                SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        filled: true,
                                        fillColor: const Color(0xffEFF0F0),
                                        labelText: "Medication",
                                        labelStyle: TextStyle(fontSize: 13),
                                        contentPadding: const EdgeInsets.only(
                                            left: 10, top: 70),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                            width: 3,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) => medication = value),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 2, color: Color(0xff38B69A)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    minimumSize: Size(300, 50),
                                  ),
                                  onPressed: () {
                                    createUser(
                                      widget.role,
                                      widget.email,
                                      widget.password,
                                      widget.fullName,
                                      widget.avatar,
                                      widget.address,
                                      widget.phoneNumber,
                                      widget.gender,
                                      widget.dateOfBirth,
                                      allergies,
                                      diseases,
                                      medication,
                                    );
                                    setState(() {
                                      isPushData = true;
                                    });
                                    Future.delayed(Duration(seconds: 2)).then((value) =>  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()),
                                    ));

                                  },
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 2, color: Color(0xff38B69A)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    minimumSize: Size(300, 50),
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PersonalInfo(
                                                role: "",
                                                email: "",
                                                password: "",
                                              )),
                                    );
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Color(0xff38B69A),
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ])),
            ),
          ),
        ),
        if (isPushData)
          Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isPushData)
          Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff2B8D78)),
                ),
              )
          )
      ],
    );
  }
}
