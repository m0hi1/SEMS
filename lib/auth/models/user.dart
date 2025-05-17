class UserModel {
  final String uid;
  final String name;
  final String email;
  final String academyName;
  final String phoneNumber;
  final String address;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.academyName,
    required this.phoneNumber,
    required this.address,
  });

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      academyName: data['academyName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
    );
  }

  // Method to convert a UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'academyName': academyName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
