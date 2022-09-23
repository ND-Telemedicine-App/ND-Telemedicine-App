import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/screens/sign_in.dart';
import 'package:nd_telemedicine_app/widgets/features/profile/shadow_container.dart';

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
  bool isLoadingData = true;

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
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: isLoadingData ? Center(child: CircularProgressIndicator()) : 
      SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: heightWidth * 0.1),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                // profile heading
                PageTitle(title: "Profile"),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(currentUser?.avatar ?? ""),
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
                Text("No status",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff031011),
                    )),
                // Info section
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffBE3050),
                    ),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Color(0xffFDFFFE),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                )
              ]))),
    );
  }
}
