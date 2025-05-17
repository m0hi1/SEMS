import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/utils/logger.dart';
import '../db/student_db.dart';
import '../model/student_model.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final Set<Student> _studentList = {};

  UnmodifiableListView<Student> get studentList =>
      UnmodifiableListView(_studentList);

  final StudentDb db;

  StudentBloc({required this.db}) : super(StudentInitial()) {
    on<GetStudentListEvent>(_getStudentList);
    on<GetFilteredStudentListEvent>(_getFilteredStudentList);
    on<AddStudentEvent>(_addStudent);
    on<GetSearchedStudentListEvent>(_getSearchedStudentList);
  }

  Future<void> _getStudentList(
      GetStudentListEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      final students = await db.getStudents();
      _studentList
        ..clear()
        ..addAll(students);

      _emitLoadedState(emit);
    } catch (e, stackTrace) {
      _emitFailureState(emit, 'Failed to fetch students', e, stackTrace);
    }
  }

//this method is used for filtering the student using batch dropdown
  Future<void> _getFilteredStudentList(
      GetFilteredStudentListEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      final filteredStudents = _studentList
          .where((student) => student.batchName == event.batch)
          .toList();

      emit(StudentLoaded(students: filteredStudents));
    } catch (e, stackTrace) {
      _emitFailureState(emit, 'Failed to filter students', e, stackTrace);
    }
  }

//this method is used for searching the student using search bar
  Future<void> _getSearchedStudentList(
      GetSearchedStudentListEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      List<Student> filteredStudents = _studentList
          .where((student) =>
              student.studentName
                  .toLowerCase()
                  .contains(event.studentName.trim().toLowerCase()) &&
              student.isActive == event.isActive)
          .toList();

      emit(StudentLoaded(students: filteredStudents));
    } catch (e, stackTrace) {
      _emitFailureState(emit, 'Failed to search students', e, stackTrace);
    }
  }

  Future<void> _addStudent(
      AddStudentEvent event, Emitter<StudentState> emit) async {
    try {
      final studentId = await db.addStudent(event.student);
      if (studentId != null) {
        _studentList.add(event.student);
        logger.i('Student added: ${event.student.studentName}');
        await FirebaseFirestore.instance
            .collection('students')
            .doc('studentId')
            .set(event.student.toFirestore()); 
        add(GetStudentListEvent());
        emit(StudentAdded());
      } else {
        throw Exception('Failed to add student to database');
      }
    } catch (e, stackTrace) {
      _emitFailureState(emit, 'Failed to add student', e, stackTrace);
    }
  }

  void _emitLoadedState(Emitter<StudentState> emit) {
    emit(StudentLoaded(students: _studentList.toList()));
  }

  void _emitFailureState(Emitter<StudentState> emit, String message, Object e,
      StackTrace stackTrace) {
    logger.e('$message: $e');
    emit(FailureState(message: '$message. Details: ${e.toString()}'));
  }
}
