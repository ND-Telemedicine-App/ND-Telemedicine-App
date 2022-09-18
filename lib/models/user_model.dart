class User {
  late final int id;
  late final String role;
  final String email;
  final String password;
  late final String fullName;
  late final String imageUrl;
  late final bool isOnline;
  late final String address;
  late final String phoneNumber;
  late final String gender;
  late final String dateOfBirth;
  late final String allergies;
  late final String diseases;
  late final String medication;

  // Used to initialise new user from the Sign Up page
  User.init({
    required this.email,
    required this.password,
  });

  // Complete User (Patient) model
  User.patient({
    required this.id,
    this.role = 'patient',
    required this.email,
    required this.password,
    required this.fullName,
    required this.imageUrl,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.allergies,
    required this.diseases,
    required this.medication,
  });

  // Adds personal info to User object
  addPersonalInfo(String fullName, String address, String phoneNumber,
      String gender, String dateOfBirth) {
    this.fullName = fullName;
    //this.imageUrl = imageUrl; to be added
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.gender = gender;
    this.dateOfBirth = dateOfBirth;
  }

  // Adds medical info to User (Patient) object
  addMedicalInfo(String allergies, String diseases, String medication) {
    this.allergies = allergies;
    this.diseases = diseases;
    this.medication = medication;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User.patient(
      id: json['id'] as int,
      role: json['role'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
      imageUrl: json['imageUrl'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      allergies: json['allergies'] as String,
      diseases: json['diseases'] as String,
      medication: json['medication'] as String,
    );
  }
}

/*
// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'ND Medicine',
  imageUrl: 'assets/images/doctor2.jpeg',
  isOnline: true,
);

// USERS
final User user1 = User(
  id: 1,
  name: 'Azubuike Siegfried',
  imageUrl: 'assets/images/doctor2.jpeg',
  isOnline: true,
);
final User user2 = User(
  id: 2,
  name: 'Medrod Klara',
  imageUrl: 'assets/images/doctor2.jpeg',
  isOnline: true,
);
final User user3 = User(
  id: 3,
  name: 'Nina Raginmund',
  imageUrl: 'assets/images/doctor2.jpeg',
  isOnline: false,
);
final User user4 = User(
  id: 4,
  name: 'Shahrzad Abdüllatif',
  imageUrl: 'assets/images/doctor2.jpeg',
  isOnline: false,
);
*/
