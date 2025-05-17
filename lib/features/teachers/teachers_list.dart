import 'package:flutter/material.dart';
import '../../admin/model/admin_model.dart'; // Ensure this imports your Teacher model

class TeacherList extends StatefulWidget {
  const TeacherList({super.key});

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  // List of teachers with their details
  final List<AdminModel> teachers = [
    AdminModel(
      name: 'Mr. Smith',
      branch: 'Mathematics',
      rating: 4.5,
      joiningDate: DateTime(2018, 8, 1),
      graduation: 'M.Sc. Mathematics',
    ),
    AdminModel(
      name: 'Mrs. Johnson',
      branch: 'Physics',
      rating: 4.8,
      joiningDate: DateTime(2019, 1, 15),
      graduation: 'M.Sc. Physics',
    ),
    AdminModel(
      name: 'Ms. Davis',
      branch: 'Chemistry',
      rating: 4.7,
      joiningDate: DateTime(2020, 9, 5),
      graduation: 'M.Sc. Chemistry',
    ),
    AdminModel(
      name: 'Mr. Brown',
      branch: 'History',
      rating: 4.2,
      joiningDate: DateTime(2017, 6, 10),
      graduation: 'M.A. History',
    ),
  ];

  // Utility to format the date without intl
  String formatDate(DateTime date) {
    // Use Dart's built-in date formatting
    return '${date.month}/${date.day}/${date.year}';
  }

  // Method to build teacher image
  Widget _buildTeacherImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
      child: Image.network(
        'https://www.worldhistoryde.org/wp-content/uploads/2021/10/JFPerson-headshot.jpg',
        fit: BoxFit.cover,
        width: 80,
        height: 120,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.error, // Fallback icon if the image fails
            size: 80,
            color: Colors.grey,
          );
        },
      ),
    );
  }

  // Method to build teacher details
  Widget _buildTeacherDetails(AdminModel teacher) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero, // No unnecessary margin
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teacher.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text('Branch: ${teacher.branch}'),
              const SizedBox(height: 4),
              Text(
                  'Rating: ${'⭐' * teacher.rating.round()} (${teacher.rating})'),
              const SizedBox(height: 4),
              Text('Joining Date: ${formatDate(teacher.joiningDate)}'),
              const SizedBox(height: 4),
              Text('Graduation: ${teacher.graduation}'),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the entire teacher card with image and details
  Widget _buildTeacherCard(AdminModel teacher) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTeacherImage(),
          const SizedBox(width: 10),
          _buildTeacherDetails(teacher),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher List'),
      ),
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          final teacher = teachers[index];
          return _buildTeacherCard(teacher);
        },
      ),
    );
  }
}
