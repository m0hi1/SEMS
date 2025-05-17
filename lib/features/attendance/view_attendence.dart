// lib/widgets/student/attendance_view_widget.dart

import 'package:flutter/material.dart';

class StudentAttendanceScreen extends StatelessWidget {
  // Dummy data for demonstration
  final Map<String, dynamic> attendanceData = {
    'totalClasses': 50,
    'presentClasses': 42.5,
    'subjects': {
      'Mathematics': {'present': 8, 'total': 10},
      'Science': {'present': 5, 'total': 5},
      'English': {'present': 3, 'total': 3},
      'Computer Science': {'present': 2, 'total': 2},
    }
  };

  @override
  Widget build(BuildContext context) {
    double attendancePercentage =
        (attendanceData['presentClasses'] / attendanceData['totalClasses']) *
            100;

    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Attendance Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAttendanceCircle(attendancePercentage),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Classes: ${attendanceData['totalClasses']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Present: ${attendanceData['presentClasses']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Absent: ${attendanceData['totalClasses'] - attendanceData['presentClasses']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Subject-wise Attendance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...attendanceData['subjects'].entries.map(
                  (subject) => _buildSubjectAttendance(
                    subject.key,
                    subject.value['present'],
                    subject.value['total'],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCircle(double percentage) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: percentage >= 75 ? Colors.green : Colors.red,
          width: 8,
        ),
      ),
      child: Center(
        child: Text(
          '${percentage.toStringAsFixed(1)}%',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: percentage >= 75 ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectAttendance(String subject, int present, int total) {
    double percentage = (present / total) * 100;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subject),
          LinearProgressIndicator(
            value: present / total,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage >= 75 ? Colors.green : Colors.red,
            ),
          ),
          Text(
            '$present/$total classes (${percentage.toStringAsFixed(1)}%)',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
