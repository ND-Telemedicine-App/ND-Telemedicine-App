import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine_app/screens/sign_in.dart';
import 'package:nd_telemedicine_app/widgets/features/profile/shadow_container.dart';

import '../main.dart';
import '../widgets/features/profile/info_row.dart';
import '../widgets/features/page_title.dart';

import '../widgets/global/globals.dart' as globals;
import '../services/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  bool isLogOut = false;
  String userStatus = '';

  //variables used for editing the user status
  bool buttonClick = true;
  IconData iconData = Icons.edit;

  bool buttonEnabled = false;

  //put requests update userStatus API from user-service
  Future<http.Response> updateUserStatus(String userStatus) {
    return http.put(
      Uri.parse(
          "http://localhost:8080/user/update-status/${globals.currentUserId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: userStatus,
    );
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    Response res = await get(
        Uri.parse("http://localhost:8080/user/${globals.currentUserId}"));

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
        status: obj['userStatus'],
      );
      setState(() {
        currentUser = thisUser;
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

  }

  void signOut() async {
    setState(() {
      globals.currentUserId = 0;
      isLogOut = true;
    });
    Navigator.pop(context);
    await Future.delayed(Duration(seconds: 2))
        .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightWidth = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: heightWidth * 0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // profile heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 40, left: 20),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        currentUser?.role == "PATIENT"
                                            ? MyStatefulWidget()
                                            : DoctorNavBar()),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                            )),
                      ),
                      PageTitle(title: "Profile"),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40, right: 20),
                        child: Icon(Icons.edit_rounded),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        currentUser?.avatar ?? "assets/images/mock_avatar.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(currentUser?.fullName ?? "",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xff78CEBB),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Stack(

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              enabled: buttonEnabled,
                              onChanged: (value) => {
                                if (value == "") {
                                  userStatus = "No Status"
                                } else {
                                  userStatus=value}
                                },
                              minLines: 1,
                              maxLines: 20,
                              maxLength: 50,
                              key: Key(currentUser?.status??"No Status"),
                              initialValue: currentUser?.status ?? "No Status",
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                  //makes a border around the textfield box
                                  // border: OutlineInputBorder(),

                                  //changes padding of text in field
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 9)),
                            ),
                          ),
                          // Align(
                          //   alignment: FractionalOffset.bottomCenter,
                          // ),
                          Container(
                            child: IconButton(
                                icon: Icon(iconData),
                                alignment: Alignment.topCenter,
                                onPressed: () {
                                  buttonClick = !buttonClick;
                                  setState(() {
                                    if (iconData == Icons.save) {
                                      buttonEnabled = false;
                                      iconData = Icons.edit;
                                      updateUserStatus(userStatus);
                                    } else {
                                      buttonEnabled = true;
                                      iconData = Icons.save;
                                    }
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(20),
                    width: screenWidth * 0.9,
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
                    child: Column(
                      children: [
                        InfoRow(
                            infoHeader: "Gender",
                            infoContent: currentUser?.gender ?? ""),
                        InfoRow(
                          infoHeader: "Email",
                          infoContent: currentUser?.email ?? "",
                        ),
                        InfoRow(
                            infoHeader: "Phone",
                            infoContent: currentUser?.phoneNumber ?? ""),
                        InfoRow(
                            infoHeader: "DOB",
                            infoContent: currentUser?.dateOfBirth ?? ""),
                        InfoRow(
                          infoHeader: "Address",
                          infoContent: currentUser?.address ?? "",
                        )
                      ],
                    ),
                  ),
                  ProfileContainer(
                    title: "Allergies",
                    content: (currentUser?.allergies ?? "").split(','),
                  ),
                  ProfileContainer(
                    title: "Diseases",
                    content: (currentUser?.diseases ?? "").split(','),
                  ),
                  ProfileContainer(
                    title: "Medication",
                    content: (currentUser?.medication ?? "").split(','),
                  ),
                  // sign out btn
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: heightWidth * 0.25,
                              color: Colors.white38,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Color(0xffBE3050),
                                            fontFamily: "PoppinsBold",
                                            fontSize: 25),
                                      ),
                                    ),
                                    Divider(
                                      indent: 60,
                                      endIndent: 60,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Are you sure you want to logout?',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Color(0xff2B8D78),
                                                    fontFamily:
                                                        "PoppinsSemiBold"),
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20), // <-- Radius
                                                  ),
                                                ),
                                                onPressed: signOut,
                                                child: Text('Logout',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "PoppinsSemiBold"))),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffBE3050),
                      ),
                      child: SizedBox(
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Color(0xffFDFFFE),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (isLogOut)
          Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLogOut)
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
