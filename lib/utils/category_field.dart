import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  final iconImagePath;
  final String categoryName;

  CategoryField({required this.iconImagePath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10) ,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(iconImagePath),
            ),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(categoryName, overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}

