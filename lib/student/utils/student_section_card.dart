import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';

class StudentSectionCard extends StatelessWidget {
  const StudentSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(237, 249, 249, 246),
        borderRadius: BorderRadius.circular(6),
      ),
      
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(Assets.studentURL),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mohit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('CSE', style: TextStyle(color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }
}
