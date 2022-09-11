import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';
import 'package:http/http.dart' as http;

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  // Input from text fields
  final patientNameController = TextEditingController();
  final medicineNameController = TextEditingController();
  final dosageInstructionsController = TextEditingController();
  final dispenseAmountController = TextEditingController();
  final medicineRefillController = TextEditingController();

  // Converts the text fields into JSON and Posts to /createPrescription
  Future<http.Response> createAlbum(String patientName, String medicineName,
      String dosageInstructions, String dispenseAmount, String medicineRefill) {
    return http.post(
      Uri.parse('http://10.0.2.2:8080/createPrescription'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'patientId': patientName,
        'medicineName': medicineName,
        'prescriptionDosage': dosageInstructions,
        'prescriptionDispense': dispenseAmount,
        'prescriptionRefill': medicineRefill,
      }),
    );
  }

  // Clean up the controllers when the widget is disposed.
  @override
  void dispose() {
    patientNameController.dispose();
    medicineNameController.dispose();
    dosageInstructionsController.dispose();
    dispenseAmountController.dispose();
    medicineRefillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightWidth = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            vertical: heightWidth * 0.1, horizontal: screenWidth * 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PageTitle(title: "Prescription"),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(
                  "Prescribe medicine for your patient!",
                  style: TextStyle(
                    color: Color(0xff38B69A),
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: 'Patient name',
                  hintStyle: TextStyle(
                    color: Color(0xff6B6C6C),
                  ),
                  fillColor: Color(0xffEFF0F0),
                  filled: true,
                ),
                controller: patientNameController,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: 'Medicine name',
                  hintStyle: TextStyle(
                    color: Color(0xff6B6C6C),
                  ),
                  fillColor: Color(0xffEFF0F0),
                  filled: true,
                ),
                controller: medicineNameController,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: null,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: 'Dosage instructions',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xff6B6C6C),
                  ),
                  fillColor: Color(0xffEFF0F0),
                  filled: true,
                ),
                controller: dosageInstructionsController,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: 'Dispense amount',
                  hintStyle: TextStyle(
                    color: Color(0xff6B6C6C),
                  ),
                  fillColor: Color(0xffEFF0F0),
                  filled: true,
                ),
                controller: dispenseAmountController,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: 'Medicine Refill',
                  hintStyle: TextStyle(
                    color: Color(0xff6B6C6C),
                  ),
                  fillColor: Color(0xffEFF0F0),
                  filled: true,
                ),
                controller: medicineRefillController,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                  // Makes container tappable
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: screenWidth * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xff38B69A),
                    ),
                    child: Center(
                      child: Text("Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xffFDFFFE),
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 18)),
                    ),
                  ),
                  onTap: () {
                    createAlbum(
                        patientNameController.text,
                        medicineNameController.text,
                        dosageInstructionsController.text,
                        dispenseAmountController.text,
                        medicineRefillController.text);
                  }),
              InkWell(
                // Makes container tappable
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: screenWidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xff38B69A), width: 3)),
                  child: const Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
