import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/widgets/features/page_title.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key, required this.avatar, required this.fullName, required this.speciality, required this.address, required this.phoneNumber, required this.bio, required this.email}) : super(key: key);
  final String avatar;
  final String fullName;
  final String speciality;
  final String email;
  final String address;
  final String phoneNumber;
  final String bio;

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double heightWidth = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(left: 20),
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            "Profile",
            style: const TextStyle(fontFamily: "PoppinsBold", fontSize: 23),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: heightWidth * 0.05),
            child: Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 40),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: AssetImage(widget.avatar),
                              height: 150,
                              width: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          widget.fullName,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "PoppinsBold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        widget.speciality,
                        style: TextStyle(
                            fontFamily: "PoppinsMediumItalic",
                            color: Colors.grey[600],
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PoppinsBold",
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.email,
                        style: TextStyle(
                            fontFamily: "PoppinsMediumItalic",
                            color: Colors.grey[600],
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Address",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PoppinsBold",
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.address,
                        style: TextStyle(
                            fontFamily: "PoppinsMediumItalic",
                            color: Colors.grey[600],
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Phone number",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PoppinsBold",
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.phoneNumber,
                        style: TextStyle(
                            fontFamily: "PoppinsMediumItalic",
                            color: Colors.grey[600],
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bio",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PoppinsBold",
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.bio,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: "PoppinsMediumItalic",
                            color: Colors.grey[600],
                        fontSize: 15),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xff38B69A),
                          ),
                          child: const Center(
                            child: Text(
                              "Book Appointment",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))));
  }
}
