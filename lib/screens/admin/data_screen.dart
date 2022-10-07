import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key, required this.users}) : super(key: key);

  final List<dynamic> users;

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
        child: Column(
          children: [
            Text(widget.users.length.toString())
          ],
        )
    ),
    ),
    );
  }
}