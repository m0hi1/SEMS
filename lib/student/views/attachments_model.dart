import 'dart:typed_data';

class AttachmentsModel {
  final int? documentId;
  final String studentId;
  final String name;
  final Uint8List imageBytes;
  AttachmentsModel(
      {this.documentId,
      required this.studentId,
      required this.name,
      required this.imageBytes});

  // Convert a Person object into a map to store in the database
  Map<String, dynamic> toMap() {
    return {
      // 'documentId': documentId,
      'studentId': studentId,
      'name': name,
      'image': imageBytes,
    };
  }

  // Convert a map retrieved from the database back into a Person object
  factory AttachmentsModel.fromMap(Map<String, dynamic> map) {
    return AttachmentsModel(
      documentId: map['documentId'] as int,
      studentId: map['studentId'] as String,
      name: map['name'] as String,
      imageBytes: map['image'] as Uint8List,
    );
  }
}
