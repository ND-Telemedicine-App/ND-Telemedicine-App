import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    double heightWidth = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffFDFFFE),
    body: SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: heightWidth * 0.1),
    child: Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
    // profile heading
    PageTitle(title: "Prescription")
    ]
    ))));
  }
}