import 'dart:ffi';

import 'package:flutter/material.dart';


class MedicalInfo extends StatefulWidget {
  const MedicalInfo({Key? key}) : super(key: key);

  @override
  State<MedicalInfo> createState() => _MedicalInfoState();


}

class _MedicalInfoState extends State<MedicalInfo> {
  final textController = TextEditingController();

  var fullName = "";


  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = textController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  final allergies = ["Peanut Butter", "Penicillin", "Aspirin", "Tree nuts", "Diary", "Others"];
  String? selectedAllergy;

  final diseases = ["Diabetes", "Cardiovascular", "Alzheimer", "Asthma", "Chest Infection", "Others"];
  String? selectedDisease;


  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item, style: const TextStyle(fontSize: 15),),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(height: 20,),
                  Text("Medical Information", style: TextStyle(color: Color(0xff2B8D78), fontSize: 25, fontFamily: 'PoppinsBold')),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text("Allergies", style: TextStyle(color: Color(0xff2B8D78), fontSize: 15, fontFamily: "PoppinsSemiBold"),),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 350,
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: const Color(0xff2B8D78), width: 3),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedAllergy,
                                  isExpanded: true,
                                  iconSize: 25,
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                                  items: allergies.map(buildMenuItem).toList(),
                                  onChanged: (value) => setState(() {
                                    selectedAllergy = value;
                                  }),
                          ),
                              )
                      )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text("Diseases", style: TextStyle(color: Color(0xff2B8D78), fontSize: 15, fontFamily: "PoppinsSemiBold"),),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Container(
                                  width: 350,
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: const Color(0xff2B8D78), width: 3),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedDisease,
                                      isExpanded: true,
                                      iconSize: 25,
                                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                                      items: diseases.map(buildMenuItem).toList(),
                                      onChanged: (value) => setState(() {
                                        selectedDisease = value;
                                      }),
                                    ),
                                  )
                              )

                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text("Medication", style: TextStyle(color: Color(0xff2B8D78), fontSize: 15, fontFamily: "PoppinsSemiBold"),),
                    ),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: textController,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: const Color(0xffEFF0F0),
                          hintText: "Medication",
                          hintStyle: TextStyle(
                              color: Colors.grey[500],fontSize: 15),
                          contentPadding: const EdgeInsets.only(left: 20, top: 80),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              width: 3,
                              style: BorderStyle.none,
                            ),
                          ),),
                        onChanged: (text) => setState(() => fullName),
                      ),

                    ),

                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xff38B69A),
                      ),
                      child: const Center(
                        child:Text("Submit", style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PoppinsSemiBold', fontSize: 18),),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff38B69A),
                          width: 3
                        )
                      ),
                      child: const Center(
                        child:Text("Cancel", style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PoppinsSemiBold', fontSize: 18),),
                      ),
                    ),
                    const SizedBox(height: 5,),

                  ],
                )
            )
          ]
      ),
    )));


  }
}
