import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final doctorImagePath;
  final String doctorName;
  final String doctorSpeciality;
  final double rating;

  DoctorCard(
      {required this.doctorImagePath,
      required this.doctorName,
      required this.doctorSpeciality,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width - 25.0 * 2,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  doctorImagePath,
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Container(
                    width: 150,
                    child: Text(
                      doctorName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "PoppinsBold",
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            doctorSpeciality,
                            style: TextStyle(
                                fontSize: 14, fontFamily: "PoppinsSemiBold"),
                          )),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(rating.toString()),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
