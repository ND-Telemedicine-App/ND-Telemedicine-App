import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(32),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF38B69A)
                ),
                // color: Color(0x38B69A),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage("assets/images/yeonjun.jpg"),
                    ),
                    Text("Choi Yeonjun")
                  ]
              ),
              )
          ]
        )
      )

    );
  }
}