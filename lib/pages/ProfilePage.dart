import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // profile heading
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
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Male"),
                          Text("cyj1309@gmail.com")
                          ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("0413939449"),
                          Text("13/09/1999")
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("123 Elizabeth St, Melbourne, VIC 3000")
                        ]
                    )
                  ]
              )
              )
          ]
        )
      )

    );
  }
}