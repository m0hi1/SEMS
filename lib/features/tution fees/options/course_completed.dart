import 'package:flutter/material.dart';

class CourseCompleted extends StatefulWidget {
  const CourseCompleted({super.key});

  @override
  State<CourseCompleted> createState() => _CourseCompletedState();
}

class _CourseCompletedState extends State<CourseCompleted> {
  // List of students who have not completed courses
  List<String> students = ['Student A', 'Student B', 'Student C', 'Student D'];

  // List of students who have completed courses
  List<String> completedStudents = [];

  // Function to mark a student as completed
  void markAsCompleted(String student) {
    setState(() {
      completedStudents.add(student);
      students.remove(student); // Remove the student from the pending list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Student List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Add your search functionality here
              print("Search clicked");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Dropdown to show the list of students
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text('Select Student to Mark as Completed'),
                    children: students.map((student) {
                      return SimpleDialogOption(
                        onPressed: () {
                          markAsCompleted(student);
                          Navigator.pop(
                              context); // Close the dialog after marking
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(student),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                markAsCompleted(student);
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text('Completed'),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  completedStudents.isEmpty
                      ? const Text('')
                      : const Text(
                          'Course Completed',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Display "No Records Found" if the completedStudents list is empty
          if (completedStudents.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No Records Found', // Display this message if no students are completed
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          else
            // Display completed students in cards
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Displaying completed students in cards
                Column(
                  children: completedStudents.map((student) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation:
                          4.0, // Adding elevation to make the card look lifted
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              student,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
