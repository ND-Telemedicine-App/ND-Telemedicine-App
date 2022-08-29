import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow ({
    Key? key,
    required this.infoHeader,
    required this.infoContent,
  }) : super(key:key);

  final String infoHeader;
  final String infoContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Flexible(child:
          Text(infoHeader,
              style: TextStyle(
                  fontWeight: FontWeight.w600
              ))
          ),
          Flexible(child: Text(infoContent))
        ],
      ),
    );
  }
}
