import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const greenApp = Color(0xff2B8D78);
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                      "assets/images/app-icon.png",
                      fit: BoxFit.cover,
                      width: 200,
                  ),
                  const SizedBox(height: 20,),
                  const Text("ND Telemedicine App", style: TextStyle(color: greenApp, fontSize: 25, fontFamily: 'PoppinsBold')),
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
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                            child:  TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffEFF0F0),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],fontSize: 15),
                                contentPadding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                            child:  TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffEFF0F0),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],fontSize: 15),
                                contentPadding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?",style: TextStyle(color: Colors.grey[600], fontSize: 15),),
                        TextButton(
                          child:  const Text(
                            'Sign Up',
                            style: TextStyle(color: Color(0xffBE3050), fontSize: 15, decoration: TextDecoration.underline,),
                          ),
                          onPressed: () {
                            //signup screen
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
                          color: Color(0xff38B69A),
                      ),
                      child: const Center(
                        child:Text("Sign In", style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PoppinsSemiBold', fontSize: 18),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    TextButton(
                      child:  const Text(
                        'Forgot Password',
                        style: TextStyle(color: Color(0xff6B6C6C), fontSize: 15, decoration: TextDecoration.underline,),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                )
            )
          ]
      ),
    );
  }
}
