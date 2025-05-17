
import 'package:flutter/material.dart';

import '../../router.dart';
import '../../shared/utils/cutom_appbar.dart';
import '../utils/student_options_card.dart';

class StudentOptionsPage extends StatelessWidget {
  const StudentOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //it can be better implemented using List<List>
    List<List> studentsOptions = [
      [
        'New Admission',
        Icons.person_add_alt_1_outlined,
        AppRoute.addStudent.path
      ],
      ['Active Students List', Icons.receipt, AppRoute.activeStudentsList.path],
      ['Inactive Students List', Icons.receipt, AppRoute.addStudent.path],
      [
        'Family Grouping',
        Icons.family_restroom_rounded,
        AppRoute.addStudent.path
      ],
      [
        'Student\'s ID Card',
        Icons.card_giftcard_outlined,
        AppRoute.addStudent.path
      ],
      [
        'Registration Forms',
        Icons.receipt_long_outlined,
        AppRoute.addStudent.path
      ],
      ['Todays\'s Birthday', Icons.cake, AppRoute.addStudent.path],
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        appBar: const MyCustomAppBar(
          title: 'Student Options',
          isSearchIconVisible: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: studentsOptions.map((list) {
              return OptionsCard(
                title: list[0],
                icon: list[1],
                path: list[2],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
