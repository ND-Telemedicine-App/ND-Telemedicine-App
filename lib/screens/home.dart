import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/utils/category_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
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
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Doctor Speciality",
                      style: TextStyle(fontFamily: "PoppinsBold", fontSize: 20),
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryField(
                          iconImagePath: "assets/icons/general.png",
                          categoryName: "General"),
                      CategoryField(
                          iconImagePath: "assets/icons/tooth.png",
                          categoryName: "Dentist"),
                      CategoryField(
                          iconImagePath: "assets/icons/view.png",
                          categoryName: "Ophthalmology"),
                      CategoryField(
                          iconImagePath: "assets/icons/surgery.png",
                          categoryName: "Surgery"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryField(
                          iconImagePath: "assets/icons/brain.png",
                          categoryName: "Neurology"),
                      CategoryField(
                          iconImagePath: "assets/icons/children.png",
                          categoryName: "Pediatric"),
                      CategoryField(
                          iconImagePath: "assets/icons/cardio.png",
                          categoryName: "Cardiology"),
                      CategoryField(
                          iconImagePath: "assets/icons/diet.png",
                          categoryName: "Nutrition"),
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Doctors",
                      style: TextStyle(fontFamily: "PoppinsBold", fontSize: 20),
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width - 25.0 * 2,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200]),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/doctor2.jpeg",
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            "Dr. C Anderson",
                            style: TextStyle(
                              fontFamily: "PoppinsBold",
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    "Cardiologists ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "PoppinsSemiBold"),
                                  )),
                              Text(
                                "The Valley Hospital",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: "PoppinsSemiBoldItalic"),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.star, size: 20, ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text("4.8")),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}