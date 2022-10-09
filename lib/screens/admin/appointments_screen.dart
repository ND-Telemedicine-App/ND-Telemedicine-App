import 'package:flutter/material.dart';

import 'dashboard.dart';

class AppointmentDataScreen extends StatefulWidget {
  const AppointmentDataScreen({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<AppointmentDataScreen> createState() => _AppointmentDataScreenState();
}

class _AppointmentDataScreenState extends State<AppointmentDataScreen> {

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
            "Appointments",
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
                                'Patient ID',
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
                                'Doctor ID',
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
                                'Start',
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
                                'End',
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
                            info["patientId"].toString(),
                            style: TextStyle(fontFamily: "PoppinsMedium"),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["doctorId"].toString(),
                            softWrap: true,
                            style: TextStyle(fontFamily: "PoppinsRegular", fontSize: 14),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["startTime"],
                            style: TextStyle(fontFamily: "PoppinsRegular"),
                          ),
                        ),
                        DataCell(
                          Text(
                            info["endTime"],
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
