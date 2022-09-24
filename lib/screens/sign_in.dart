import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/screens/forgot_password.dart';
import 'package:nd_telemedicine_app/screens/home.dart';
import 'package:nd_telemedicine_app/screens/personal_info.dart';
import 'package:nd_telemedicine_app/screens/profile_screen.dart';
import 'package:nd_telemedicine_app/screens/sign_up.dart';
import 'package:nd_telemedicine_app/services/models/user_model.dart';

import '../widgets/global/globals.dart' as globals;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late List users;
  List patients = [];
  late User currentUser;
  String userEmail = "";
  String userPassword = "";
  bool isDone = false;
  late bool validateStatus;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<List> getUsers() async {
    Response res = await get(Uri.parse("http://localhost:8080/users"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);

      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }

  void convertFutureListToList() async {
    Future<List> futureOfList = getUsers();
    users = await futureOfList;
    for (dynamic user in users) {
      if (user['role'] == "PATIENT") {
        User newPatient = User(
            id: user['id'],
            role: user['role'],
            email: user['email'],
            password: user['password'],
            fullName: user['fullName'],
            avatar: user['avatar'],
            address: user['address'],
            phoneNumber: user['phoneNumber'],
            gender: user['gender'],
            dateOfBirth: user['dateOfBirth'],
            allergies: user['allergies'],
            diseases: user['diseases'],
            medication: user['medication'],
            bio: user['bio'],
            speciality: user['speciality']);

        setState(() {
          patients.add(newPatient);
        });
      }
    }
  }

  bool checkEmailAndPassword() {
    if (!userEmail.contains("@") || userEmail == "" || userPassword == "") {
      return false;
    }
    for (dynamic patient in patients) {
      if (patient.email == userEmail && patient.password == userPassword) {
        setState(() {
          currentUser = patient;
          globals.currentUserId = currentUser.id!;
        });
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertFutureListToList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("ND Telemedicine App",
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
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              child: TextFormField(
                                controller: emailController,
                                onChanged: (email) {
                                  userEmail = email;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xffEFF0F0),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
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
                              child: TextFormField(
                                controller: passwordController,
                                onChanged: (password) {
                                  userPassword = password;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xffEFF0F0),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
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
                            "Don't have an account?",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                          ),
                          TextButton(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xffBE3050),
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
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
                        child: InkWell(
                          onTap: () async {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => PersonalInfo()),
                            // );
                            // print(userEmail);
                            // cyj1309@gmail.com password
                            if (checkEmailAndPassword()) {
                              print("User exists");
                              setState(() {
                                isDone = true;
                              });
                              await Future.delayed(Duration(seconds: 3));
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            } else {
                              setState(() {
                                isDone = true;
                              });
                              await Future.delayed(Duration(seconds: 1));
                              setState(() {
                                isDone = false;
                              });
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Center(
                                      child: Text(
                                    'Alert',
                                    style: TextStyle(
                                        color: Color(0xff38B69A),
                                        fontFamily: "PoppinsBold",
                                        fontSize: 20),
                                  )),
                                  content: Text(
                                    'Email or password is incorrect.',
                                    style:
                                        TextStyle(fontFamily: "PoppinsMedium"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(); // dismisses only the dialog and returns nothing
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              print("No user found");
                            }
                          },
                          splashColor: Color(0xff38B69A),
                          child: Center(
                            child: Text(
                              "Sign In",
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
                      TextButton(
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Color(0xff6B6C6C),
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()),
                          );
                        },
                      )
                    ],
                  ))
            ]),
      ),
      if (isDone)
        Opacity(
          opacity: 0.8,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
      if (isDone)
        Center(
            child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff2B8D78)),
          ),
        ))
    ]);
  }
}
