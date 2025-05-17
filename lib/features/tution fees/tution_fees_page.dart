import 'package:flutter/material.dart';
import 'package:sems/features/tution%20fees/options/add_fees.dart';
import 'package:sems/features/tution%20fees/options/course_completed.dart';
import 'package:sems/features/tution%20fees/options/fee_collection_report.dart';
import 'package:sems/features/tution%20fees/options/fees_reminder.dart';

class TutionFeesPage extends StatelessWidget {
  const TutionFeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Fees Options",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        children: [
          _buildCard(
            context,
            title: "Add Fees",
            imagePath: 'assets/icons/add_fees.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddFees(),
                ),
              );
            },
          ),
          _buildCard(
            context,
            title: "Fees Reminder",
            imagePath: 'assets/icons/fees_reminder.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeesReminder(),
                ),
              );
            },
          ),
          _buildCard(
            context,
            title: "Fee Collection Report",
            imagePath: 'assets/icons/fees_collection.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeeCollectionReport(),
                ),
              );
            },
          ),
          _buildCard(
            context,
            title: "Course Completed",
            imagePath: 'assets/icons/course_completed.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourseCompleted(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required String imagePath,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(35, 48, 191, 1.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
