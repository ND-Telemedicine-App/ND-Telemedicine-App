
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../services/models/user_model.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.time, required this.date, required this.doctorId}) : super(key: key);

  final String time;
  final String date;
  final int doctorId;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  User? doctor;
   bool visible = true;

  Future<Map<String, dynamic>> getDoctor() async {
    Response res = await get(
        Uri.parse("http://localhost:8080/user/${widget.doctorId}"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      User thisUser = User(
        id: obj['id'],
        role: obj['role'],
        email: obj['email'],
        password: obj['password'],
        fullName: obj['fullName'],
        avatar: obj['avatar'],
        address: obj['address'],
        phoneNumber: obj['phoneNumber'],
        gender: obj['gender'],
        dateOfBirth: obj['dateOfBirth'],
        allergies: obj['allergies'],
        diseases: obj['diseases'],
        medication: obj['medication'],
        bio: obj['bio'],
        speciality: obj['speciality'],
      );
      setState(() {
        doctor = thisUser;
      });
      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctor();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Visibility(
        visible: visible,
        child: Card(
          elevation: 10,
          color: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      height: 80,
                      child: Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage("assets/images/main_logo.png"),
                            height: 120,
                            width: 120,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "You have an appointment with Dr ${doctor?.fullName} at ${widget.time} on ${widget.date}!",
                            style: TextStyle(fontSize: 12, fontFamily: "PoppinsMedium", color: Colors.black),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close_rounded),
                  onPressed: () {
                    setState(() {
                      visible = false;
                    });
                  },
                  iconSize: 20,
                  highlightColor: Theme.of(context).primaryColor,
                  splashRadius: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
