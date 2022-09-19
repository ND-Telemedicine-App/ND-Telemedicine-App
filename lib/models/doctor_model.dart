class Doctor {
  final String imagePath;
  final String name;
  final String speciality;
  final String bio;

  Doctor({
    required this.imagePath,
    required this.name,
    required this.speciality,
    required this.bio,
  });
}

List<Doctor> doctors = [
  Doctor(
      imagePath: "assets/images/hansooyoung.jpg",
      name: "Han Sooyoung",
      speciality: "Neurologist",
      bio: "I love writing"),
  Doctor(
      imagePath: "assets/images/Junho.png",
      name: "Go Junho",
      speciality: "Dermatologist",
      bio: "Mystery crimes"),
  Doctor(
      imagePath: "assets/images/kieran.jpg",
      name: "Kieran White",
      speciality: "Neurologist",
      bio: "Purple Hyacinth"),
  Doctor(
      imagePath: "assets/images/Bella.jpg",
      name: "Belladonna Davenport",
      speciality: "Pathologist",
      bio: "Venom"),
];