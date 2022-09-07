class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });
}

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
final User user2= User(
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
final User user4= User(
  id: 4,
  name: 'Shahrzad Abdüllatif',
  imageUrl: 'assets/images/doctor2.jpeg',
  isOnline: false,
);
