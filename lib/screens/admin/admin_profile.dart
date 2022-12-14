import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/screens/admin/dashboard.dart';

import '../../services/models/user_model.dart';
import '../../widgets/features/page_title.dart';
import '../../widgets/features/profile/info_row.dart';
import '../../widgets/global/globals.dart' as globals;
import '../sign_in.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  User? currentUser;
  bool isLogOut = false;

  //variables used for editing the user status
  bool buttonClick = true;
  IconData iconData = Icons.edit;

  bool buttonEnabled = false;

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
                                    builder: (context) => DashboardScreen()),
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
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Color(0xffBE3050),
                                          fontFamily: "PoppinsBold",
                                          fontSize: 25),
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
