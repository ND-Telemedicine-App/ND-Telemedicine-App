import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String content;

  const ArticleCard({required this.title, required this.content});

 @override
  Widget build(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 10,
      child: Container(
        width: screenWidth * 0.5,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        //margin: EdgeInsets.only(bottom: 40),
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
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Container(
                    child: Text(title,
                      style: TextStyle(
                        color: Color(0xff38b69a),
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                ReadMoreText(content,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            )
        ),
      );
  }
}