import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/screens/chat_menu.dart';
import 'package:nd_telemedicine_app/screens/doctor_profile.dart';
import 'package:nd_telemedicine_app/screens/profile_screen.dart';
import 'package:nd_telemedicine_app/widgets/features/home/article_card.dart';

import '../services/models/user_model.dart';
import '../widgets/global/globals.dart' as globals;
import '../widgets/features/doctor/doctor_booking_card.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {

  User? currentUser;
  bool isLoadingData = true;

  Future<List> getDoctors() async {
    Response res = await get(Uri.parse("http://localhost:8080/user/doctors"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: isLoadingData ? Center(child: CircularProgressIndicator(),) :
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  App Bar
                Padding(
                  padding: EdgeInsets.only(top: 20),
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Icons.notifications,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,MaterialPageRoute(builder: (context) => ChatMenu()),);
                              },
                              child: Icon(Icons.message_rounded,
                                  color: Colors.black))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                Container(
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

                SizedBox(
                  height: 5,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
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
                                "How are your patients today?",
                                style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Message them now to get an update!",
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
                                    "Message",
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
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Articles",
                        style:
                        TextStyle(fontFamily: "PoppinsBold", fontSize: 20),
                      ),
                      SizedBox(height: 20,),
                      ArticleCard(title: "How to calm a patient with anxiety", content: "Drink water, fresh juice. Dr. Baek Dohwa, who used to work with anxiety patients, recommend us to work out."),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Patients",
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
                SizedBox(height: 20,),

                FutureBuilder<List>(
                  future: getDoctors(),
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
                                  ["speciality"]),
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
      ),
    );
  }

}