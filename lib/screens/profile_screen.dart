import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/profile/shadow_container.dart';

import '../widgets/features/profile/info_row.dart';
import '../widgets/features/page_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.avatar, required this.fullName, required this.gender, required this.email, required this.phoneNumber, required this.dateOfBirth, required this.address, required this.allergies, required this.diseases, required this.medication}) : super(key: key);

  final String avatar;
  final String fullName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String address;
  final String allergies;
  final String diseases;
  final String medication;



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffFDFFFE),
        body: SingleChildScrollView(
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
                    backgroundImage: AssetImage(widget.avatar),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(widget.fullName,
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
                            InfoRow(infoHeader: "Gender", infoContent: widget.gender),
                            InfoRow(
                                infoHeader: "Email", infoContent: widget.email),
                            InfoRow(infoHeader: "Phone", infoContent: widget.phoneNumber),
                            InfoRow(infoHeader: "DOB", infoContent: widget.dateOfBirth),
                            InfoRow(
                                infoHeader: "Address",
                                infoContent: widget.address)
                          ],
                        ),
                      ),
                  ProfileContainer(
                    title: "Allergies",
                    content: const ["Peanut Butter", "Aspirin", "Dairy", "Penicillin", "Tree nuts"]
                  ),
                  ProfileContainer(
                    title: "Diseases",
                    content: const ["Major depression", "Diabetes type 2"],
                     ),
                  ProfileContainer(
                    title: "Medication",
                    content: const ["Citalopram", "Insulin"],
                  ),
                      // sign out btn
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xffBE3050),
                      ),
                        child: Text("Sign Out",
                          style: TextStyle(
                            color: Color(0xffFDFFFE),
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                          )),
                      )
                ]))));
  }
}