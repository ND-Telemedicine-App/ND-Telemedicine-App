import 'package:flutter/material.dart';

import 'dashboard.dart';

class PatientDataScreen extends StatefulWidget {
  const PatientDataScreen({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<PatientDataScreen> createState() => _PatientDataScreenState();
}

class _PatientDataScreenState extends State<PatientDataScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
            },
          ),
          centerTitle: true,
          title: Text(
            "Patients",
            style: const TextStyle(fontFamily: "PoppinsBold"),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                children: [
                  DataTable(
                      dataRowHeight: 80,
                      border: TableBorder.all(
                        width: 2,
                        color: Color(0xffeff0f0),
                      ),
                      columns: const [
                        // table header
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Address',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'DOB',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Allergies',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Diseases',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Medication',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Status',
                                style: TextStyle(
                                  color: Color(0xff2b8d78),
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          numeric: false,
                        ),
                      ], rows: <DataRow>[
                    ...widget.data.map(
                          (info) => DataRow(cells: [
                        DataCell(
                          Text(
                            info["fullName"],
                            style: TextStyle(fontFamily: "PoppinsMedium"),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["email"],
                            softWrap: true,
                            style: TextStyle(fontFamily: "PoppinsRegular", fontSize: 14),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["address"],
                            style: TextStyle(fontFamily: "PoppinsRegular"),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["phoneNumber"],
                            style: TextStyle(fontFamily: "PoppinsRegular"),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["gender"],
                            style: TextStyle(fontFamily: "PoppinsRegular"),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["dateOfBirth"],
                            style: TextStyle(fontFamily: "PoppinsRegular"),
                          ),
                        ),
                        DataCell(
                          Container(
                            child: Text(
                              info["allergies"],
                              style: TextStyle(fontFamily: "PoppinsRegular",),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["diseases"],
                            style: TextStyle(fontFamily: "PoppinsRegular"),
                          ),
                        ),
                        DataCell(
                              Text(
                                info["medication"],
                                style: TextStyle(fontFamily: "PoppinsRegular"),
                              ),
                            ),
                        DataCell(
                              Text(
                                info["userStatus"],
                                style: TextStyle(fontFamily: "PoppinsRegular"),
                              ),
                            ),
                      ],),
                    )
                  ]
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}