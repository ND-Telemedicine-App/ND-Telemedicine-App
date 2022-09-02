import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    required this.title,
    required this.content
  }) : super(key:key);

  final String title;
  final List<String> content;


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(20),
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFDFFFE),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              offset: Offset(0.5, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                Text(title),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
            Row(
              children: <Widget>[
                for(var i in content) Text(i)
              ],
            )
          ],
        )
    );
  }
}