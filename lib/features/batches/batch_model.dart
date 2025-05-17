// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class BatchModel extends Equatable {
  final int? batchId;
  final String batchName;
  final String isActive;
  final String batchLocation;
  final String batchTime;
  final String batchAdmin;
  final String batchDays;
  final int batchMaximumSlots;
  final String createdAt;
  const BatchModel({
    this.batchId,
    required this.batchName,
    required this.isActive,
    required this.batchLocation,
    required this.batchTime,
    required this.batchAdmin,
    required this.batchDays,
    required this.batchMaximumSlots,
    required this.createdAt,
  });

  // batchMaximumSlots: map['batchMaximumSlots'] as int,

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'batchId': batchId,
      'batchName': batchName,
      'isActive': isActive,
      'batchLocation': batchLocation,
      'batchTime': batchTime,
      'batchAdmin': batchAdmin,
      'batchDays': batchDays,
      'batchMaximumSlots': batchMaximumSlots,
      'createdAt': createdAt
    };
  }

  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      batchId: map['batchId'] as int,
      batchName: map['batchName'] as String,
      isActive: map['isActive'] as String,
      batchLocation: map['batchLocation'] as String,
      batchTime: map['batchTime'] as String,
      batchAdmin: map['batchAdmin'] as String,
      batchDays: map['batchDays'] as String,
      batchMaximumSlots: map['batchMaximumSlots'] as int,
      createdAt: map['createdAt'] as String,
    );
  }

  //TODO : Implement props here if add new fields
  @override
  List<Object?> get props => [
        batchId,
        batchName,
        isActive,
        batchLocation,
        batchTime,
        batchAdmin,
        batchDays,
        batchMaximumSlots,
        createdAt
      ];
}
