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
      children: <Widget> [
        Text("$infoHeader: "),
        Text(infoContent)
      ],
    );
  }
}
