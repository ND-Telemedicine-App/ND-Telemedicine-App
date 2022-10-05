import 'package:flutter/material.dart';

class TimeSlot {

  // this name is the patient name if the timeslot is an appointment
  // if it's a busy time, the name will be "Busy"
  final String name;
  final DateTime start;
  final DateTime end;
  final Color background;

  TimeSlot(this.name, this.start, this.end, this.background);

}