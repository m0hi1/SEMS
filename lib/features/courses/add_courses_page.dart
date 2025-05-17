import 'package:sems/features/courses/db/course_db.dart';
import 'package:sems/shared/utils/custom_textfield.dart';
import 'package:sems/shared/utils/cutom_appbar.dart';
import 'package:sems/shared/utils/full_space_button.dart';
import 'package:flutter/material.dart';

class AddCoursesPage extends StatefulWidget {
  const AddCoursesPage({super.key});

  @override
  State<AddCoursesPage> createState() => _AddCoursesPageState();
}

class _AddCoursesPageState extends State<AddCoursesPage> {
  TextEditingController courseNameController = TextEditingController();

  final GlobalKey formKey = GlobalKey<FormState>();

  CourseDb? courseDbRef;

  @override
  void initState() {
    super.initState();
    //here i am getting the database instance from the StudentDb class
    // which is used for adding the student to the database
    courseDbRef = CourseDb.dbInstance;
    //TODO: call the getCourse function from the CourseDb class
    // i have to remove this later
    courseDbRef!.getCourses();
  }

  bool isLoading = false;

  void clearFields() {
    courseNameController.clear();
  }

  Future<bool> addCourse() async {
    //here i am calling the addNote function from the StudentDb class
    // which is used for adding the student to the database
    if (!(formKey.currentState as FormState).validate()) {
      return false;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final bool isExecuted =
          await courseDbRef!.addCourse(courseNameController.text);

      clearFields();

      return isExecuted;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      // this will set the isLoading to false
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const MyCustomAppBar(title: 'Add Courses Page'),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomTextField(
                                title: 'Course Name',
                                controller: courseNameController,
                              ),

                              // this sized box is used for giving some space between the textfield and the button
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: FullSpaceButton(
                      onPressed: addCourse,
                    ))
              ],
            ),
    );
  }
}
