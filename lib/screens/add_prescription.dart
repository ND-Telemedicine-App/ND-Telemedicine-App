import 'package:flutter/material.dart';

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
            children: <Widget> [
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
                fillColor: Color(0xffEFF0F0),
                filled: true,
              ),

            ),
  ],
        ),
    ),
    ),);
  }
}

