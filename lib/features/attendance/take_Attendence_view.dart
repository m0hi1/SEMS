import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sems/features/attendance/attendance_model.dart';
import 'package:sems/features/attendance/bloc/attendance_bloc.dart';
import 'package:sems/features/attendance/selection_chip.dart';
import 'package:sems/features/attendance/student_attendance_card.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/shared/utils/cutom_appbar.dart';
import 'package:sems/shared/utils/date_picker.dart';
import 'package:sems/student/model/student_model.dart';

import '../../student/bloc/student_bloc.dart';

class TakeAttendanceScreen extends StatefulWidget {
  final BatchModel batch;

  const TakeAttendanceScreen({super.key, required this.batch});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  DateTime selectedDate = DateTime.now();
  late TextEditingController dateController;
  final Map<String, int> attendanceValues = {};
  List<Student> stud = [];

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: formatDate(selectedDate));
    _fetchData();
  }

  void _fetchData() {
    context.read<StudentBloc>().add(GetStudentListEvent());
    context
        .read<AttendanceBloc>()
        .add(GetAttendancesEvent(dateController.text));
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  void _updateDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      dateController.text = formatDate(selectedDate);
    });
    _fetchData();
  }

  void _changeDate(int days) {
    final newDate = selectedDate.add(Duration(days: days));
    if (newDate.isAfter(DateTime.now())) {
      Fluttertoast.showToast(
          msg: "Date cannot be after today", toastLength: Toast.LENGTH_SHORT);
      return;
    }
    _updateDate(newDate);
  }

  void _submitAttendance() {
    final attendanceText =
        attendanceValues.entries.map((e) => "${e.key}:${e.value}").join(", ");
    final attendance = AttendanceModel(
      date: dateController.text,
      attendances: attendanceText,
      batchId: widget.batch.batchId.toString(),
      createdAt: DateTime.now().toString(),
      batchName: widget.batch.batchName,
    );
    context.read<AttendanceBloc>().add(AddAttendancesEvent(attendance));
    Fluttertoast.showToast(
        msg: "Attendance Added", toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[300],
          onPressed: _submitAttendance,
          child: const Icon(Icons.check, color: Colors.white),
        ),
        appBar: const MyCustomAppBar(
            title: "Take Attendance", isSearchIconVisible: false),
        backgroundColor: Colors.grey[200],
        body: Column(
          // spacing: 2,
          children: [
            const SizedBox(
              height: 5,
            ),
            _buildDateSelector(),
            const Center(child: Text("Click to set all")),
            Expanded(
                child: MultiBlocListener(
              listeners: [
                BlocListener<StudentBloc, StudentState>(
                  listener: (context, state) {
                    if (state is StudentLoaded) {
                      stud = state.students;
                    }
                  },
                ),
                BlocListener<AttendanceBloc, AttendanceState>(
                  listener: (context, state) {
                    if (state is AttendanceLoaded) {
                      _parseAttendance(state.attendance.attendances);
                    } else {
                      // print(stud);
                      _initializeAttendance(stud);
                    }
                  },
                ),
                BlocListener<StudentBloc, StudentState>(
                  listener: (context, state) {
                    if (state is StudentLoaded) {
                      _initializeAttendance(state.students);
                    }
                  },
                ),
              ],
              child: BlocBuilder<StudentBloc, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoaded) {
                    return _buildAttendanceList(state.students);
                  }
                  return const Center(child: Text("No Data"));
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dateButton(Icons.arrow_back, () => _changeDate(-1)),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              DateTime? newDate =
                  await pickDate(context, dateController, isLastDate: true);
              if (newDate != null) {
                _updateDate(newDate);
                _fetchData();
              }
              ;
            },
            child: Container(
              height: 50,
              color: Colors.blue[900],
              alignment: Alignment.center,
              child: Text(
                dateController.text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        _dateButton(Icons.arrow_forward, () => _changeDate(1)),
      ],
    );
  }

  Widget _dateButton(IconData icon, VoidCallback onPressed) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.blue,
      child: IconButton(
          icon: Icon(icon, size: 30, color: Colors.white),
          onPressed: onPressed),
    );
  }

  Widget _buildAttendanceList(List<Student> students) {
    return Column(
      children: [
        //this one is to select all at ones
        SelectionChipCard(
          initialValues: attendanceValues,
          students: students,
          onAllValuesUpdated: () {
            setState(() {});
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: students.length,
          itemBuilder: (context, index) {
            return StudentAttendanceCard(
              student: students[index],
              rollNo: students[index].rollNumber,
              initialValues: attendanceValues,
            );
          },
        ),
      ],
    );
  }

  void _initializeAttendance(List<Student> students) {
    setState(() {
      for (var student in students) {
        attendanceValues.putIfAbsent(student.rollNumber, () => 0);
      }
    });
  }


  void _parseAttendance(String? attendanceData) {
    if (attendanceData == null || attendanceData.isEmpty) return;
    for (var entry in attendanceData.split(',')) {
      final keyValue = entry.split(':');
      if (keyValue.length == 2) {
        final key = keyValue[0].trim();
        final value = int.tryParse(keyValue[1].trim()) ?? 0;
        attendanceValues[key] = value;
      }
    }
  }
}

String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
