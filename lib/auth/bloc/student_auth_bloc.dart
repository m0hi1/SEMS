import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/student/db/student_db.dart';

import 'auth_bloc.dart';

class StudentAuthBloc extends Bloc<AuthEvent, AuthState> {
  final StudentDb _studentDb;

  StudentAuthBloc({required StudentDb studentDb})
      : _studentDb = studentDb,
        super(AuthInitial()) {
    on<StudentLogin>(_onStudentLogin);
  }

  Future<void> _onStudentLogin(event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final student = await _studentDb.verifyStudentLogin(
        academyId: event.academyId,
        studentId: event.studentId,
        dateOfBirth: event.dateOfBirth,
      );
      if (student != null) {
        if (student.isActive) {
          emit(AuthSuccess(user: student));
        } else {
          emit(AuthError(message: 'Your account is deactivated'));
        } 
      } else {
        emit(AuthError(message: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
