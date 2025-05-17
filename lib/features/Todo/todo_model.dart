import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  final int? taskId;
  final String taskDescription; // "What is to be done?"
  final String remarks;
  final String priority; // Could be 'Low', 'Medium', 'High'
  final String
      dueDate; // Assuming date is stored as a string, you can also use DateTime
  final String
      dueTime; // Assuming time is stored as a string, you can also use DateTime
  final String repeat; // Repeat type: 'No Repeat', 'Daily', etc.
  final String taskType; // Could be 'Default', 'Other', etc.
  bool isSelected;

  TodoModel(
      {this.taskId,
      required this.taskDescription,
      required this.remarks,
      required this.priority,
      required this.dueDate,
      required this.dueTime,
      required this.repeat,
      this.isSelected = false,
      required this.taskType});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'taskDescription': taskDescription,
      'remarks': remarks,
      'priority': priority,
      'dueDate': dueDate,
      'dueTime': dueTime,
      'repeat': repeat,
      'taskType': taskType,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      taskId: map['taskId'] as int?,
      taskDescription: map['taskDescription'] as String,
      remarks: map['remarks'] as String,
      priority: map['priority'] as String,
      dueDate: map['dueDate'] as String,
      dueTime: map['dueTime'] as String,
      repeat: map['repeat'] as String,
      taskType: map['taskType'] as String,
    );
  }

  @override
  List<Object?> get props => [
        taskId,
        taskDescription,
        remarks,
        priority,
        dueDate,
        dueTime,
        repeat,
        taskType,
      ];
}
