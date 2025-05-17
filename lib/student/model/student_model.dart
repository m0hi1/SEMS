// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sems/auth/views/role_selection_signin.dart';

import '../views/attachments_model.dart';

class Student {
  final String uid;
  final UserRole role;

  final Uint8List? profileImageBytes;
  final String acadmyId;
  final String studentId;
  final String rollNumber;
  final String studentName;
  final String guardianName;
  final String dateOfBirth;
  final String mobileNumber1;
  final String mobileNumber2;
  final String gender;
  final String address;
  final String batchName;
  final String feeType;
  final String startDate;
  final String classOrSubject;
  final String schoolName;
  final String optionalField1;
  final String optionalField2;
  final String optionalField3;
  final bool isActive;

  final List<AttachmentsModel>? attachments;
  Student({
    this.profileImageBytes,
    required this.acadmyId,
    required this.studentId,
    required this.rollNumber,
    required this.studentName,
    required this.guardianName,
    required this.dateOfBirth,
    required this.mobileNumber1,
    required this.mobileNumber2,
    required this.gender,
    required this.address,
    required this.batchName,
    required this.feeType,
    required this.startDate,
    required this.classOrSubject,
    required this.schoolName,
    required this.optionalField1,
    required this.optionalField2,
    required this.optionalField3,
    required this.uid,
    this.attachments,
    required this.isActive,
    this.role = UserRole.student,
  });

  Student copyWith({
    String? uid,
    UserRole? role,
    Uint8List? profileImageBytes,
    String? acadmyId,
    String? studentId,
    String? rollNumber,
    String? studentName,
    String? guardianName,
    String? dateOfBirth,
    String? mobileNumber1,
    String? mobileNumber2,
    String? gender,
    String? address,
    String? batchName,
    String? feeType,
    String? startDate,
    String? classOrSubject,
    String? schoolName,
    String? optionalField1,
    String? optionalField2,
    String? optionalField3,
    bool? isActive,
    List<AttachmentsModel>? attachments,
  }) {
    return Student(
        uid: uid ?? this.uid,
        role: role ?? this.role,
        profileImageBytes: profileImageBytes ?? this.profileImageBytes,
        acadmyId: acadmyId ?? this.acadmyId,
        studentId: studentId ?? this.studentId,
        rollNumber: rollNumber ?? this.rollNumber,
        studentName: studentName ?? this.studentName,
        guardianName: guardianName ?? this.guardianName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        mobileNumber1: mobileNumber1 ?? this.mobileNumber1,
        mobileNumber2: mobileNumber2 ?? this.mobileNumber2,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        batchName: batchName ?? this.batchName,
        feeType: feeType ?? this.feeType,
        startDate: startDate ?? this.startDate,
        classOrSubject: classOrSubject ?? this.classOrSubject,
        schoolName: schoolName ?? this.schoolName,
        optionalField1: optionalField1 ?? this.optionalField1,
        optionalField2: optionalField2 ?? this.optionalField2,
        optionalField3: optionalField3 ?? this.optionalField3,
        attachments: attachments ?? this.attachments,
        isActive: isActive.toString() == 'true' ? true : false);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'acadmyId': acadmyId,
      'studentId': studentId,
      'rollNumber': rollNumber,
      'studentName': studentName,
      'guardianName': guardianName,
      'dateOfBirth': dateOfBirth,
      'mobileNumber1': mobileNumber1,
      'mobileNumber2': mobileNumber2,
      'gender': gender,
      'address': address,
      'batchName': batchName,
      'feeType': feeType,
      'startDate': startDate,
      'classOrSubject': classOrSubject,
      'schoolName': schoolName,
      'optionalField1': optionalField1,
      'optionalField2': optionalField2,
      'optionalField3': optionalField3,
      'attachments': attachments,
      'isActive': isActive.toString(),
      'profileImage': profileImageBytes,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'role': role,
      'academyId': acadmyId,
      'studentId': studentId,
      'rollNumber': rollNumber,
      'studentName': studentName,
      'guardianName': guardianName,
      'dateOfBirth': dateOfBirth,
      'mobileNumber1': mobileNumber1,
      'mobileNumber2': mobileNumber2,
      'gender': gender,
      'address': address,
      'batchName': batchName,
      'feeType': feeType,
      'startDate': startDate,
      'classOrSubject': classOrSubject,
      'schoolName': schoolName,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      uid: map['uid']?.toString() ?? '',
      role: map['role'] ?? UserRole.student,
      acadmyId: map['acadmyId']?.toString() ?? '',
      profileImageBytes: map['profileImage'] as Uint8List?,
      studentId: map['studentId']?.toString() ?? '',
      rollNumber: map['rollNumber']?.toString() ?? '',
      studentName: map['studentName']?.toString() ?? '',
      guardianName: map['guardianName']?.toString() ?? '',
      dateOfBirth: map['dateOfBirth']?.toString() ?? '',
      mobileNumber1: map['mobileNumber1']?.toString() ?? '',
      mobileNumber2: map['mobileNumber2']?.toString() ?? '',
      gender: map['gender']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      batchName: map['batchName']?.toString() ?? '',
      feeType: map['feeType']?.toString() ?? '',
      startDate: map['startDate']?.toString() ?? '',
      classOrSubject: map['classOrSubject']?.toString() ?? '',
      schoolName: map['schoolName']?.toString() ?? '',
      optionalField1: map['optionalField1']?.toString() ?? '',
      optionalField2: map['optionalField2']?.toString() ?? '',
      optionalField3: map['optionalField3']?.toString() ?? '',
      attachments: map['attachments'] as List<AttachmentsModel>?,
      isActive: map['isActive'] == 'true' ? true : false,
    );
  }
}
