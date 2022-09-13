class Prescription {
  final int id;
  final int patientId;
  final int doctorId;
  final String medicineName;
  final String dosageInstructions;
  final String dispenseAmount;
  final String medicineRefill;
  final String prescriptionDate;

  const Prescription({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.medicineName,
    required this.dosageInstructions,
    required this.dispenseAmount,
    required this.medicineRefill,
    required this.prescriptionDate,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'] as int,
      patientId: json['patientId'] as int,
      doctorId: json['doctorId'] as int,
      medicineName: json['medicineName'] as String,
      dosageInstructions: json['prescriptionDosage'] as String,
      dispenseAmount: json['prescriptionDispense'] as String,
      medicineRefill: json['prescriptionRefill'] as String,
      prescriptionDate: json['prescriptionDate'] as String,
    );
  }
}
