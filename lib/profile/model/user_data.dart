class UserData {
  final String name;
  final String email;
  final String academyName;
  final String academyId;
  final String? phoneNumber;
  final String? address;

  UserData({
    required this.name,
    required this.email,
    required this.academyName,
    required this.academyId,
    this.phoneNumber,
    this.address,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      email: map['email'],
      academyName: map['academyName'],
      academyId: map['academyId'],
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
