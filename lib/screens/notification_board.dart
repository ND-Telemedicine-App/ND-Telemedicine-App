import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/services/models/appointment_model.dart';
import 'package:nd_telemedicine_app/widgets/features/notification/notification_card.dart';

import '../main.dart';

import '../widgets/global/globals.dart' as globals;

class NotificationBoard extends StatefulWidget {
  const NotificationBoard({Key? key}) : super(key: key);

  @override
  State<NotificationBoard> createState() => _NotificationBoardState();
}

class _NotificationBoardState extends State<NotificationBoard> {
  Future<List> getAppointmentsOfCurrentUser() async {
    var api =
        'http://localhost:8090/appointment/patient/${globals.currentUserId}';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointmentsOfCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyStatefulWidget()),
                          );
                        },
                        iconSize: 25,
                        highlightColor: Theme.of(context).primaryColor,
                        splashRadius: 20,
                      ),
                      Text("Notification",
                          style: TextStyle(
                              color: Color(0xff2B8D78),
                              fontSize: 25,
                              fontFamily: 'PoppinsBold')),
                      IconButton(
                        icon: Icon(Icons.more_horiz_rounded),
                        onPressed: () {},
                        iconSize: 25,
                        highlightColor: Theme.of(context).primaryColor,
                        splashRadius: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder(
                    future: getAppointmentsOfCurrentUser(),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NotificationCard(
                                doctorId: snapshot.data?[index]['doctorId'],
                                time: snapshot.data?[index]['startTime']
                                    .substring(11, 16),
                                date: snapshot.data?[index]['startTime']
                                    .substring(0, 10),
                              );
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
