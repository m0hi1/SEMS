part of 'student_bloc.dart';

//sealed means it can't be accessed outside the file

// import 'package:equatable/equatable.dart';

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

//initial state
final class StudentInitial extends StudentState {
  @override
  List<Object> get props => [];
}

//loading state
final class StudentLoading extends StudentState {
  @override
  List<Object> get props => [];
}

//error state
final class FailureState extends StudentState {
  final String message;
  const FailureState({required this.message});
  @override
  List<Object> get props => [message];
}

//this used for getting the notes
final class StudentLoaded extends StudentState {
  final List<Student> students;
  const StudentLoaded({required this.students});
  @override
  List<Object> get props => [students];
}

final class GetStudentById extends StudentState {
  final Student student;
  const GetStudentById({required this.student});
  @override
  List<Object> get props => [student];
}

final class StudentEdited extends StudentState {
  @override
  List<Object> get props => [];
}

final class StudentDeleted extends StudentState {
  @override
  List<Object> get props => [];
}

final class StudentAdded extends StudentState {
  @override
  List<Object> get props => [];
}
