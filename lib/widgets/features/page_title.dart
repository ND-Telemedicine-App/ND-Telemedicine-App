import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle ({
    Key? key,
    required this.title,
  }) : super(key:key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: Text(title,
          style: TextStyle(
              color: Color(0xff2B8D78),
              fontFamily: 'PoppinsBold',
              fontSize: 25
          )),
    );
  }
}