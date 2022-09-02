import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    required this.title,
    required this.content
  }) : super(key:key);

  final String title;
  final List<String> content;

  Widget getItemWidgets(List<String> elements)
  {
    List<Widget> items = <Widget>[];
    for (var i = 0; i < elements.length; i++) {
      items.add(Container(
        margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffDDFFF8),
          ),
        child: Text(elements[i]),
        ));
    }
    return Wrap(spacing: 10, alignment: WrapAlignment.start, children: items);
  }

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
            crossAxisAlignment :CrossAxisAlignment.stretch,
          children: <Widget> [
            Row(
              children: <Widget> [
                Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                )),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
            getItemWidgets(content)
          ],
        )
    );
  }
}