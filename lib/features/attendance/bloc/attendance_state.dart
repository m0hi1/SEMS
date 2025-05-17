part of 'attendance_bloc.dart';

//sealed means it can't be accessed outside the file
sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

//initial state
final class AttendanceInitial extends AttendanceState {
  @override
  List<Object> get props => [];
}

//loading state
final class AttendanceLoading extends AttendanceState {
  @override
  List<Object> get props => [];
}

//error state
final class FailureState extends AttendanceState {
  final String message;

  const FailureState({required this.message});

  @override
  List<Object> get props => [message];
}

//this used for getting the Attendances
final class AttendanceLoaded extends AttendanceState {
  final AttendanceModel attendance;

  const AttendanceLoaded({required this.attendance});

  @override
  List<Object> get props => [attendance];
}

final class AttendancesAdded extends AttendanceState {
  @override
  List<Object> get props => [];
}

// final class GetBatchById extends AttendanceState {
//   final BatchModel batch;
//
//   const GetBatchById({required this.batch});
//
//   @override
//   List<Object> get props => [batch];
// }

// final class BatchEdited extends AttendanceState {
//   @override
//   List<Object> get props => [];
// }

// final class BatchDeleted extends AttendanceState {
//   @override
//   List<Object> get props => [];
// }
