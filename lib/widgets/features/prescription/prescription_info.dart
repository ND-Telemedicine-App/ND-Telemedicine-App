import 'package:flutter/material.dart';

class PrescriptionInfo extends StatelessWidget {
  const PrescriptionInfo ({
    Key? key,
    required this.infoHeader,
    required this.infoContent,
  }) : super(key:key);

  final String infoHeader;
  final String infoContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text("$infoHeader: ",
        style: TextStyle(
          fontFamily: "PoppinsSemiBold",
          height: 1.75,
          fontSize: 18
        )),
        Flexible(
          child: Text(infoContent, style: TextStyle(height: 1.75, fontSize: 18)),
        )
      ],
    );
  }
}
