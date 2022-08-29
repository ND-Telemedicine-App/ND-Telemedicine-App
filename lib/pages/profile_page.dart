import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/shadow_container.dart';

import '../widgets/features/info_row.dart';
import '../widgets/features/page_title.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                backgroundImage: AssetImage("assets/images/yeonjun.jpg"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text("Choi Yeonjun",
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
                  ShadowContainer(content: Column(children: const [
                    InfoRow(infoHeader: "Gender", infoContent: "Male"),
                    InfoRow(
                        infoHeader: "Email", infoContent: "cyj1309@gmail.com"),
                    InfoRow(infoHeader: "Phone", infoContent: " 0413939449"),
                    InfoRow(infoHeader: "DOB", infoContent: "13/09/1999"),
                    InfoRow(
                        infoHeader: "Address",
                        infoContent: " 123 Elizabeth St, Melbourne, VIC 3000")
                  ])),
              ShadowContainer(content: Column(
                  children: const [
                    Text("Allergies"),
                    Icon(Icons.keyboard_arrow_down),
                    Text("Ya"),
                  ],
                )),
            ShadowContainer(content: Column(
                  children: const [
                  Text("Diseases"),
                  Icon(Icons.keyboard_arrow_down),
                  Text("Ya"),
              ],
            )),
            ShadowContainer(content: Column(
              children: const [
                Text("Medication"),
                Icon(Icons.keyboard_arrow_down),
                Text("Ya"),
              ],
            )),
            ]))
        ));
  }
}