import 'package:flutter/material.dart';

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
      body: Center(
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
                      color: Color(0xff031011),
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
                margin: EdgeInsets.symmetric(vertical: 40),
                padding: EdgeInsets.all(20),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xffFDFFFE),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 40,
                      offset: Offset(0.5, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    InfoRow(infoHeader: "Gender", infoContent: "Male"),
                    InfoRow(infoHeader: "Email", infoContent: "cyj1309@gmail.com"),
                    InfoRow(infoHeader: "Phone", infoContent: " 0413939449"),
                    InfoRow(infoHeader: "DOB", infoContent: "13/09/1999"),
                    InfoRow(infoHeader: "Address", infoContent: " 123 Elizabeth St, Melbourne, VIC 3000")
                  ]
              )
              )
          ]
        )
      )

    );
  }
}