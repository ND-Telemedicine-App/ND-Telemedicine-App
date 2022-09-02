import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:nd_telemedicine_app/widgets/features/prescription/Prescription_Container.dart';

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
        children: const [
    // profile heading
          PageTitle(title: "Prescription"),
          PrescriptionContainer(number: 1, drugName: "ABC",
              usage: "1 tablet after each meal", dispense: "28 tablets",
              refill: "1", date: "13/03/2021", signature: "Choi Beomgyu")
    ]
    ))));
  }
}