class Appointment {
  int? id;
  int? patientId;
  int? doctorId;
  String? startTime;
  String? endTime;

  Appointment(
      {this.id, this.patientId, this.doctorId, this.startTime, this.endTime});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    doctorId = json['doctorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['doctorId'] = this.doctorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}