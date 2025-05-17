import 'package:flutter/material.dart';

import '../model/student_model.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  const StudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 11, 38, 160),
                        width: 2)),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  foregroundImage: student.profileImageBytes == null
                      ? const AssetImage('assets/images/scholar_cap.png')
                      : MemoryImage(student.profileImageBytes!)
                          as ImageProvider<Object>?,
                ),
              ),
            ),
            Text(
              student.gender,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              student.studentId,
              style: const TextStyle(
                color: Colors.blue,
                // fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              student.batchName,
              style: const TextStyle(
                color: Color.fromARGB(255, 90, 89, 89),
                fontSize: 15,
              ),
            ),
            Text(
              student.mobileNumber1,
              style: const TextStyle(
                color: Color.fromARGB(255, 90, 89, 89),
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(student.studentName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 65, 4, 156),
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            Text(
              student.classOrSubject,
              style: const TextStyle(
                color: Color.fromARGB(255, 90, 89, 89),
                fontSize: 15,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              student.startDate,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
