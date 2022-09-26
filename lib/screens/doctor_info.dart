import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/home.dart';

import 'package:http/http.dart' as http;
import 'package:nd_telemedicine_app/screens/sign_in.dart';
import 'package:nd_telemedicine_app/screens/sign_up.dart';

import '../services/models/user_model.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo(
      {Key? key,
      required this.role,
      required this.email,
      required this.password})
      : super(key: key);

  final String role;
  final String email;
  final String password;

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

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
    String speciality,
    String bio) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/createUser'),
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
      'speciality': speciality,
      'bio': bio
    }),
  );

  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create User.');
  }
}

class _DoctorInfoState extends State<DoctorInfo> {
  String fullName = "";
  String address = "";
  String phoneNumber = "";
  String gender = "";
  String dateOfBirth = "";
  String speciality = "";
  String bio = "";

  bool isPushData = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
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
                          Text(
                            "Doctor Information",
                            style: TextStyle(
                              color: Color(0xff2B8D78),
                              fontSize: 25,
                              fontFamily: 'PoppinsBold',
                            ),
                          ),
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
                                    backgroundImage: AssetImage(
                                        "assets/images/mock_avatar.png"),
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
                                      onChanged: (value) => {fullName = value},
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xffEFF0F0),
                                        labelText: "Full Name",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15),
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, top: 20, bottom: 20),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                      onChanged: (value) =>
                                          {speciality = value},
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xffEFF0F0),
                                        labelText: "Speciality",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15),
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, top: 20, bottom: 20),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                      onChanged: (value) => {bio = value},
                                      minLines: 4,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xffEFF0F0),
                                        labelText: "Tell us about yourself...",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                  fullName,
                                  'assets/images/mock_avatar.png',
                                  address,
                                  phoneNumber,
                                  gender,
                                  dateOfBirth,
                                  speciality,
                                  bio,
                                );
                                setState(() {
                                  isPushData = true;
                                });
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInPage()),
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
          ))
      ],
    );
  }
}
