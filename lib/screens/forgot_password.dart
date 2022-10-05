import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/otp.dart';
import 'package:nd_telemedicine_app/screens/sign_in.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo_cover.png",
                    fit: BoxFit.cover,
                    width: 400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Forgot your password?",
                      style: TextStyle(
                          color: Color(0xff2B8D78),
                          fontSize: 25,
                          fontFamily: 'PoppinsBold')),
                  const SizedBox(
                    height: 20,
                  ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Enter your email and verify OTP to reset your password",
                        style:
                            TextStyle(fontFamily: "PoppinsMedium", fontSize: 15),
                      ),
                    ),

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
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 8, bottom: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffEFF0F0),
                                labelText: "Email",

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
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: Size(300, 50),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,MaterialPageRoute(builder: (context) => Otp()),);
                        },
                        child: Text('Get Code',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 18))),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            width: 2, color: Color(0xff38B69A)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize: Size(300, 50),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,MaterialPageRoute(builder: (context) => SignInPage()),);
                      },
                      child: Text('Cancel',
                        style: TextStyle(
                          color: Color(0xff38B69A),
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 18,),),),

                  ],
                ))
          ]),
    );
  }
}
