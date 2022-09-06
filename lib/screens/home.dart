import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          //  App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("assets/images/kuri.jpeg"),
                        )),
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
                          "Username",
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
                    Icon(Icons.message_rounded, color: Colors.black)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12)),
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
                          "How do you feel today?",
                          style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Fill out your medical form!",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
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
                              "Get started",
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

          SizedBox(
            height: 5,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Container(
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
          ),

          SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 80,
              child: ListView(
                children: [
                  Container(
                    child: Row(
                      children: [Text("Dentist")],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
