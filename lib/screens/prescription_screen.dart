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
              usage: "1 tablet - 30 minutes after each meal everyday", dispense: "28 tablets",
              refill: "1", date: "13/03/2021", doctor: "Choi Beomgyu"),
          PrescriptionContainer(number: 2, drugName: "PH liquid med",
              usage: "20ml before bed", dispense: "2 bottles, 250ml each",
              refill: "1", date: "30/12/2021", doctor: "Go Junho"),
          PrescriptionContainer(number: 3, drugName: "ORV",
              usage: "2 pills per day - take after lunch", dispense: "1 bottle - 60 pills",
              refill: "None", date: "01/04/2021", doctor: "Han Sooyoung"),
    ]
    ))));
  }
}