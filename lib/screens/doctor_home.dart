import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/api/get_api.dart';
import 'package:nd_telemedicine_app/screens/chat_menu.dart';
import 'package:nd_telemedicine_app/screens/doctor_profile.dart';
import 'package:nd_telemedicine_app/screens/profile_screen.dart';
import 'package:nd_telemedicine_app/widgets/features/home/article_card.dart';
import 'package:nd_telemedicine_app/widgets/features/patient/patient_card.dart';

import '../services/models/user_model.dart';
import '../widgets/global/globals.dart' as globals;

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {

  User? currentUser;
  bool isLoadingData = true;
  String patientUri = "https://telemedicine-user-service.herokuapp.com/user/patients";

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
    getData(patientUri);
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
                                  AssetImage(currentUser?.avatar??"assets/images/mock_avatar.png"),
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
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,MaterialPageRoute(builder: (context) => ChatMenu()),);
                                  },
                                  child: Container(
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
                                  ))
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
                        "Quick Tips",
                        style:
                        TextStyle(fontFamily: "PoppinsBold", fontSize: 20),
                      ),
                      SizedBox(height: 20,),
                      ArticleCard(title: "Dealing with anxiety?", content: "Drink water, fresh juice. Dr. Baek Dohwa, who used to work with anxiety patients, recommend us to work out. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."),
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
                  future: getData(patientUri),
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
                                  patientId: snapshot.data?[index]['id'],
                                  patientImagePath: snapshot.data?[index]['avatar'],
                                  patientName: snapshot.data?[index]["fullName"],
                                  patientStatus: snapshot.data?[index]
                                  ["userStatus"]),
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