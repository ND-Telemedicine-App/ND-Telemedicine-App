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

  List<String> allergies = ["Peanut Butter", "Penicillin", "Aspirin", "Tree nuts", "Diary"];
  String selectedAllergy = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: const Text("Allergies", style: TextStyle(color: Color(0xff2B8D78), fontFamily: "PoppinsMedium"),),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(2),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Center(
                    //         child: DropdownButton(
                    //           hint: const Text('Allergy: '),
                    //           value: selectedAllergy,
                    //           onChanged: (newValue) {
                    //             setState(() {
                    //               selectedAllergy = newValue;
                    //             });
                    //           },
                    //           items: allergies.map((allergy) {
                    //             return DropdownMenuItem(
                    //               value: allergy,
                    //               child: Text(allergy),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
    );
  }
}
