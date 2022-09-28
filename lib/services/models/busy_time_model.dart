import 'package:flutter/cupertino.dart';
import 'dart:convert';

BusyTime busyTimeJson(String str) =>
    BusyTime.fromJson(json.decode(str));

String busyTimeModelToJson(BusyTime data) => json.encode(data.toJson());

class BusyTime {
  int? id;
  int? doctorId;
  String? busyTime;
  int? duration;

  BusyTime(
      {this.id, this.doctorId, this.busyTime, this.duration});

  factory BusyTime.fromJson(Map<String, dynamic> json) => BusyTime(
      id: json['id'],
      doctorId: json['doctorId'],
      busyTime: json['busyTime'],
      duration: json['duration']);

  Map<String, dynamic> toJson() => {
    "id" : id,
    "doctorId" : doctorId,
    "busyTime" : busyTime,
    "duration" : duration,
  };

  String? getBusyTime() => busyTime;
  int? getDuration() => duration;
}