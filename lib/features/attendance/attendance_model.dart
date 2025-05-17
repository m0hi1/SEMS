// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final String date;
  final String? attendances;
  final String batchId;
  final String batchName;
  final String? createdAt;

  const AttendanceModel({
    required this.date,
    // this.rollNo,
    // this.attendanceStatus,
    this.attendances,
    this.createdAt,
    required this.batchId,
    required this.batchName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'attendances': attendances,
      'batchId': batchId,
      'createdAt': createdAt,
      'batchName': batchName,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      batchName: map['batchName'] as String,
      date: map['date'] as String,
      attendances: map['attendances'] as String,
      createdAt: map['createdAt'] as String,
      batchId: map['batchId'] as String,
    );
  }

  //TODO : Implement props here if add new fields
  @override
  List<Object?> get props => [
        date,
        attendances,
        createdAt,
        batchId,
        batchName,
      ];
}
