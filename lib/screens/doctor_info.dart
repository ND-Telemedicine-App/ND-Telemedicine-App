import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/home.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({Key? key}) : super(key: key);

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {

  var fullName = "";
  final fullNameController = TextEditingController();
  final specialityController = TextEditingController();
  final bioController = TextEditingController();

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
                      Text("Doctor Information",
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
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    // errorText: _errorText,
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Full Name",
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
                                child: TextFormField(
                                  controller: specialityController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    labelText: "Speciality",
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
                                  controller: bioController,
                                  minLines: 4,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEFF0F0),
                                    hintText: "Tell us about yourself...",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    contentPadding: const EdgeInsets.all(20),
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
                                  builder: (context) => HomeScreen()
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
                                "SUBMIT",
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
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
