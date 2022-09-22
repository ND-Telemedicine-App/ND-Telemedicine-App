import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedRole;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontSize: 15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
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
                children: <Widget>[
                  Image.asset(
                    "assets/images/main_logo.png",
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                  const Text("Create your account",
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
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              children: <Widget>[
                                Center(
                                    child: Container(
                                      width: screenWidth * 0.85,
                                        margin: const EdgeInsets.only(
                                        bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color(0xff2B8D78),
                                                width: 3),
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        child: DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: DropdownButton<String>(
                                              value: selectedRole,
                                              hint: Text("Are you a..."),
                                              isExpanded: true,
                                              iconSize: 25,
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                              items: ["PATIENT", "DOCTOR"]
                                                  .map(buildMenuItem)
                                                  .toList(),
                                              onChanged: (value) => setState(() {
                                                selectedRole = value;
                                              }),
                                            ),
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.85,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffEFF0F0),
                                hintStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                                contentPadding: const EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                labelText: 'Email',
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
                            width: screenWidth * 0.85,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffEFF0F0),
                                labelText: 'Password',
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
                            width: screenWidth * 0.85,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffEFF0F0),
                                labelText: "Confirm Password",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                        ),
                        TextButton(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xffBE3050),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context) => SignInPage()),);
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xff38B69A),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ))
          ]),
    );
  }
}
