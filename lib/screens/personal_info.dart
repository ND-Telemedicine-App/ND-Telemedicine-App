import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/medical_info.dart';
import 'package:nd_telemedicine_app/screens/sign_in.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  var fullName = "";

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = fullNameController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Personal Information",
                          style: TextStyle(
                              color: Color(0xff2B8D78),
                              fontSize: 25,
                              fontFamily: 'PoppinsBold')),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: 130,
                          height: 130,
                          child: Column(
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/mock_avatar.png"),
                                radius: 50,
                                foregroundColor: Colors.green,
                                backgroundColor: Colors.transparent,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  "Upload your avatar",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextField(
                                  controller: fullNameController,
                                  decoration: InputDecoration(
                                    errorText: _errorText,
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    hintText: "Full name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) => setState(() => fullName),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    hintText: "Address",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    hintText: "Phone number",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextField(
                                  controller: genderController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    hintText: "Gender",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 8, bottom: 8),
                                child: TextField(
                                  controller: dateOfBirthController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    hintText: "Date of birth",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 20, bottom: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedicalInfo(
                                    role: 'PATIENT',
                                    email: 's3722961@student.rmit.edu.au',
                                    password: 'password',
                                    fullName: fullNameController.text,
                                    avatar: 'test.png',
                                    address: addressController.text,
                                    phoneNumber: phoneNumberController.text,
                                    gender: genderController.text,
                                    dateOfBirth: dateOfBirthController.text,
                                  ),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 25),
                            height: 50,
                            width: screenWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xff38B69A),
                            ),
                            child: const Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            width: screenWidth * 0.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Color(0xff38B69A), width: 3)),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
