import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/admin/dashboard.dart';

class DoctorDataScreen extends StatefulWidget {
  const DoctorDataScreen({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<DoctorDataScreen> createState() => _DoctorDataScreenState();
}

class _DoctorDataScreenState extends State<DoctorDataScreen> {

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
        body: SafeArea(
          child: Center(
            child: DataTable(columns: const [
              DataColumn(
                label: Text(
                  'Email',
                  style: TextStyle(
                    color: Color(0xff2b8d78),
                    fontSize: 18.0,
                  ),
                ),
                numeric: false,
              ),
              DataColumn(
                label: Text(
                  'Full Name',
                  style: TextStyle(
                    color: Color(0xff2b8d78),
                    fontSize: 18.0,
                  ),
                ),
                numeric: false,
              ),
              DataColumn(
                label: Text(
                  'Address',
                  style: TextStyle(
                    color: Color(0xff2b8d78),
                    fontSize: 18.0,
                  ),
                ),
                numeric: false,
              ),
            ], rows: <DataRow>[
              ...widget.data.map(
                (info) => DataRow(cells: [
                  DataCell(
                    Container(
                      width: 100,
                      child: Text(
                        info["email"],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 60.0,
                      child: Center(
                        child: Text(
                          info["fullName"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 60.0,
                      child: Center(
                        child: Text(
                          info["address"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ]
                //             rows: widget.data
                //             .map((info) => DataRow(
                //               cells: [
                //               DataCell(
                //               Container(
                //               width: 100,
                //               child: Text(
                //                 info["email"],
                //                 softWrap: true,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: TextStyle(fontWeight: FontWeight.w600),
                //               ),
                //             ),
                //             ),
                //       ]
                // )
                //             )
                ),
          ),
        ));
  }
}
