import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/screens/chat_menu.dart';
import 'package:nd_telemedicine_app/screens/notification_board.dart';
import 'package:nd_telemedicine_app/screens/profile_screen.dart';
import 'package:nd_telemedicine_app/utils/category_field.dart';
import '../api/get_api.dart';
import '../widgets/features/doctor/doctor_booking_card.dart';
import '../widgets/global/globals.dart' as globals;
import '../services/models/user_model.dart';
import 'doctor_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? currentUser;
  bool isLoadingData = true;
  String getDoctorUri = "https://telemedicine-user-service.herokuapp.com/user/doctors";

  Future<Map<String, dynamic>> getCurrentUser() async {
    Response res = await get(
        Uri.parse("https://telemedicine-user-service.herokuapp.com/user/${globals.currentUserId}"));

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
        currentUser = thisUser;
        isLoadingData = false;
      });
      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData(getDoctorUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingData ? Center(child: CircularProgressIndicator(),) :
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              //  App Bar
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),),
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 12),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage(currentUser?.avatar??""),
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Good morning,",
                              style: TextStyle(
                                  fontFamily: "PoppinsItalic", fontSize: 14),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              currentUser?.fullName??"",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "PoppinsSemiBold",
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context) => NotificationBoard()),);
                          },
                          iconSize: 25,
                          highlightColor: Theme.of(context).primaryColor,
                          splashRadius: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.message_rounded),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context) => ChatMenu()),);
                          },
                          iconSize: 25,
                          highlightColor: Theme.of(context).primaryColor,
                          splashRadius: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: "How can we help you?",
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/home_med.png",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How do you feel today?",
                              style: TextStyle(
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Fill out your medical form!",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Get started",
                                  style: TextStyle(
                                      fontFamily: "PoppinsMedium",
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Doctor Speciality",
                      style:
                          TextStyle(fontFamily: "PoppinsBold", fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        "See more",
                        style: TextStyle(
                            fontFamily: "PoppinsMedium",
                            fontSize: 13,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryField(
                            iconImagePath: "assets/icons/general.png",
                            categoryName: "General"),
                        CategoryField(
                            iconImagePath: "assets/icons/tooth.png",
                            categoryName: "Dentist"),
                        CategoryField(
                            iconImagePath: "assets/icons/view.png",
                            categoryName: "Ophthalmology"),
                        CategoryField(
                            iconImagePath: "assets/icons/surgery.png",
                            categoryName: "Surgery"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryField(
                            iconImagePath: "assets/icons/brain.png",
                            categoryName: "Neurology"),
                        CategoryField(
                            iconImagePath: "assets/icons/children.png",
                            categoryName: "Pediatric"),
                        CategoryField(
                            iconImagePath: "assets/icons/cardio.png",
                            categoryName: "Cardiology"),
                        CategoryField(
                            iconImagePath: "assets/icons/diet.png",
                            categoryName: "Nutrition"),
                      ],
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Doctors",
                        style:
                            TextStyle(fontFamily: "PoppinsBold", fontSize: 20),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () => {},
                        child: Text(
                          "See more",
                          style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 13,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),

              FutureBuilder<List>(
                future: getData(getDoctorUri),
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
                            child: DoctorBookingCard(
                                doctorImagePath: snapshot.data?[index]['avatar'],
                                doctorName: snapshot.data?[index]["fullName"],
                                doctorSpeciality: snapshot.data?[index]
                                ["speciality"],
                                doctorId: snapshot.data?[index]["id"],
                            ),
                          );
                        }
                      // },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
