import 'dart:ffi';

class User {
  Long? id;
  String? role;
  String? email;
  String? password;
  String? fullName;
  String? avatar;
  String? address;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;
  String? allergies;
  String? diseases;
  String? medication;
  String? bio;
  String? speciality;

  User(
      {this.id,
        this.role,
        this.email,
        this.password,
        this.fullName,
        this.avatar,
        this.address,
        this.phoneNumber,
        this.gender,
        this.dateOfBirth,
        this.allergies,
        this.diseases,
        this.medication,
        this.bio,
        this.speciality});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    allergies = json['allergies'];
    diseases = json['diseases'];
    medication = json['medication'];
    bio = json['bio'];
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['allergies'] = this.allergies;
    data['diseases'] = this.diseases;
    data['medication'] = this.medication;
    data['bio'] = this.bio;
    data['speciality'] = this.speciality;
    return data;
  }
}