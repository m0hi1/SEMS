import 'package:sems/student/db/student_grid_icon_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../../shared/utils/grid_icon_data.dart';
import '../../shared/widget/grid_button_widget.dart';

class StudentGridSection extends StatelessWidget {
  const StudentGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10, bottom: 0, left: 5, right: 5),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: SizedBox(
        height: 300,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // mainAxisSpacing: 10,
            // crossAxisSpacing: 10,
          ),
          itemCount: studentIconData.length,
          itemBuilder: (context, index) {
            return GridButton(
              icon: studentIconData[index]['icon'],
              label: studentIconData[index]['label'],
              color: studentIconData[index]['color'],
              onTap: () {
                switch (index) {
                  case 0:
                    context.push(AppRoute.academyScreen.path);
                    break;
                  case 1:
                    context.push(AppRoute.viewAttendance.path);
                    break;
                  case 2:
                    context.push(AppRoute.studenttutionfees.path);
                    break;
                  case 3:
                    context.push(AppRoute.studyMaterial.path);
                    break;

                  default:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '📢 Coming Soon',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.amberAccent,
                      ),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
