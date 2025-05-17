import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/features/attendance/selection_chip.dart';
import 'package:sems/student/model/student_model.dart';

import '../../student/bloc/student_bloc.dart';

class StudentAttendanceCard extends StatelessWidget {
  const StudentAttendanceCard({
    super.key,
    required this.student,
    required this.initialValues,
    required this.rollNo,
  });

  final Student student;
  final Map<String, int> initialValues;
  final String rollNo;

  @override
  Widget build(BuildContext context) {
    final StudentBloc studentBloc = context.read<StudentBloc>();
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    //TODO: academy id need to be added
                    Text(
                      student.studentId,
                      style: const TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Text(
                      student.batchName,
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      student.studentName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(student.classOrSubject,
                        style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
            SelectionChipCard(
              initialValues: initialValues,
              rollNo: rollNo,
            ),
          ],
        ),
      ),
    );
  }
}
