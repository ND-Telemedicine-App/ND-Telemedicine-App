import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    double heightWidth = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: heightWidth * 0.1, horizontal: screenWidth * 0.1),
        child: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              PageTitle(title: "Prescription"),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text("Prescribe medicine for your patient!",
                style: TextStyle(color: Color(0xff38B69A),),),
            ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
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
              ),
              SizedBox(height: 30,),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
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
            ),
              SizedBox(height: 30,),
              TextFormField(
                maxLines: null,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
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
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
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
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
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
              ),
              SizedBox(height: 30,),
  ],
        ),
    ),
    ),);
  }
}

