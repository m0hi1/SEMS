// import 'package:sems/features/courses/db/course_db.dart';
// import 'package:sems/features/students/db/student_db.dart';
// import 'package:sems/utils/custom_textfield.dart';
// import 'package:sems/utils/cutom_appbar.dart';
// import 'package:sems/utils/full_space_button.dart';
// import 'package:flutter/material.dart';

// class AddStudentPage extends StatefulWidget {
//   const AddStudentPage({super.key});

//   @override
//   State<AddStudentPage> createState() => _AddStudentPageState();
// }

// class _AddStudentPageState extends State<AddStudentPage> {
//   TextEditingController rollNumberController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController courseController = TextEditingController();
//   TextEditingController semController = TextEditingController();

//   final GlobalKey formKey = GlobalKey<FormState>();

//   StudentDb? studentDbRef;
//   CourseDb? courseDbRef;

//   List<String>? classes;

//   @override
//   void initState() {
//     super.initState();
//     //here i am getting the database instance from the StudentDb class
//     // which is used for adding the student to the database
//     studentDbRef = StudentDb.dbInstance;
//     courseDbRef = CourseDb.dbInstance;

//     studentDbRef!.getStudents();
//     getCourse();
//   }

//   void getCourse() async {
//     classes = await courseDbRef!.getCourses();
//     setState(() {});
//   }

//   bool isLoading = false;

//   void clearFields() {
//     rollNumberController.clear();
//     firstNameController.clear();
//     lastNameController.clear();
//     phoneNumberController.clear();
//     courseController.clear();
//     semController.clear();
//   }

//   Future<bool> addStudent() async {
//     //here i am calling the addNote function from the StudentDb class
//     // which is used for adding the student to the database
//     if (!(formKey.currentState as FormState).validate()) {
//       return false;
//     }

//     try {
//       setState(() {
//         isLoading = true;
//       });

//       final bool isExecuted = await studentDbRef!.addStudent(
//           rollNumber: rollNumberController.text,
//           firstName: firstNameController.text,
//           lastName: lastNameController.text,
//           phoneNumber: phoneNumberController.text,
//           course: courseController.text,
//           className: semController.text);

//       clearFields();

//       return isExecuted;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     } finally {
//       // this will set the isLoading to false
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true,
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Stack(
//               fit: StackFit.expand,
//               children: [
//                 Form(
//                   key: formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const MyCustomAppBar(title: 'Add Student Page'),
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 20),
//                           padding: const EdgeInsets.symmetric(vertical: 5),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               CustomTextField(
//                                 title: 'Roll Number',
//                                 isNumeric: true,
//                                 controller: rollNumberController,
//                               ),
//                               CustomTextField(
//                                 title: 'First Name',
//                                 controller: firstNameController,
//                               ),
//                               CustomTextField(
//                                 title: 'Last Name',
//                                 controller: lastNameController,
//                               ),
//                               CustomTextField(
//                                 title: 'Phone Number',
//                                 isNumeric: true,
//                                 isMobile: true,
//                                 controller: phoneNumberController,
//                               ),
//                               // this sized box is used for giving some space between the textfield and the button
//                               DropdownButtonFormField<String>(
//                                 validator: (value) => value == null
//                                     ? 'Please select a class'
//                                     : null,
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: const InputDecoration(
//                                   labelText: 'Class',
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 items: classes?.map((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                                 onChanged: (val) {
//                                   courseController.text = val!;
//                                 },
//                               ),

//                               CustomTextField(
//                                 title: 'Semester',
//                                 controller: semController,
//                               ),
//                               const SizedBox(
//                                 height: 50,
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: FullSpaceButton(
//                       onPressed: addStudent,
//                     ))
//               ],
//             ),
//     );
//   }
// }
