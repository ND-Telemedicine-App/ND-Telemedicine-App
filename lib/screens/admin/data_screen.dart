import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/admin/dashboard.dart';

class DoctorDataScreen extends StatefulWidget {
  const DoctorDataScreen({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<DoctorDataScreen> createState() => _DoctorDataScreenState();
}

class _DoctorDataScreenState extends State<DoctorDataScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardScreen()));
          },
        ),
        centerTitle: true,
        title: Text(
          "Patients",
          style: const TextStyle(fontFamily: "PoppinsBold"),
        ),
      ),
        body: SafeArea(
        child: Center(
        child: Column(
          children: [
            Text(widget.data.length.toString())
          ],
        )
    ),
    ),
    );
  }
}