class BusyTime {
  final int id;
  final int doctorId;
  final String startTime;
  final int duration;

  const BusyTime(
      {required this.id, required this.doctorId, required this.startTime, required this.duration});

  factory BusyTime.fromJson(Map<String, dynamic> json) => BusyTime(
      id: json['id'] as int,
      doctorId: json['doctorId'] as int,
      startTime: json['busyTime'] as String,
      duration: json['duration'] as int);

  Map<String, dynamic> toJson() => {
    "id" : id,
    "doctorId" : doctorId,
    "busyTime" : startTime,
    "duration" : duration,
  };

  String getStartTime() => startTime;
  int getDuration() => duration;
}