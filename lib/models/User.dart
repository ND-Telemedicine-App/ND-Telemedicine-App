import 'dart:ffi';

class User {
  final Long id;
  final String role;
  final String email;
  final String password;
  final String fullName;
  final String avatar;
  final String address;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;
  final String allergies;
  final String diseases;
  final String medication;
  final String bio;
  final String speciality;
  final String userStatus;

  User({
    required this.id,
    required this.role,
    required this.email,
    required this.password,
    required this.fullName,
    required this.avatar,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.allergies,
    required this.diseases,
    required this.medication,
    required this.bio,
    required this.speciality,
    required this.userStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      avatar: json['avatar'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      allergies: json['allergies'],
      diseases: json['diseases'],
      medication: json['medication'],
      bio: json['bio'],
      speciality: json['speciality'],
      userStatus: json['userStatus'],
    );
  }
}
