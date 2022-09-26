import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/medical_info.dart';
import 'package:nd_telemedicine_app/screens/sign_in.dart';
import 'package:nd_telemedicine_app/screens/sign_up.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo(
      {Key? key,
      required this.role,
      required this.email,
      required this.password})
      : super(key: key);

  final String role;
  final String email;
  final String password;

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String fullName = "";
  String address = "";
  String phoneNumber = "";
  String gender = "";
  String dateOfBirth = "";

  bool checkInfo() {
    if(fullName != "" && address != "" && phoneNumber != "" && gender != "" && dateOfBirth != ""){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Personal Information",
                          style: TextStyle(
                              color: Color(0xff2B8D78),
                              fontSize: 25,
                              fontFamily: 'PoppinsBold')),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: 130,
                          height: 130,
                          child: Column(
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/mock_avatar.png"),
                                radius: 50,
                                foregroundColor: Colors.green,
                                backgroundColor: Colors.transparent,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  "Upload your avatar",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextFormField(
                                  onChanged: (value) {
                                    fullName = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Full name",
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextFormField(
                                  onChanged: (value) {
                                    address = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Address",
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextFormField(
                                  onChanged: (value) {
                                    phoneNumber = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Phone number",
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextFormField(
                                  onChanged: (value) {
                                    gender = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Gender",
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextFormField(
                                  onChanged: (value) {
                                    dateOfBirth = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Date of birth",
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              minimumSize: Size(300, 50),
                            ),
                            onPressed: () {
                              if(checkInfo()){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicalInfo(role: widget.role, email: widget.email, password: widget.password,
                                        avatar: 'assets/images/mock_avatar.png',
                                        fullName: fullName, address: address, phoneNumber: phoneNumber,
                                        gender: gender,dateOfBirth: dateOfBirth,)),
                                );
                              }
                            },
                            child: Text('Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 18))),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 2, color: Color(0xff38B69A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              minimumSize: Size(300, 50),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Color(0xff38B69A),
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 18,),),),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
