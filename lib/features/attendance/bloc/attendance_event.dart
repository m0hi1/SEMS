part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {}

class GetAttendancesEvent extends AttendanceEvent {
  final String date;

  GetAttendancesEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class AddAttendancesEvent extends AttendanceEvent {
  final AttendanceModel attendances;

  AddAttendancesEvent(this.attendances);

  @override
  List<Object?> get props => [attendances];
}

class UpdateAttendancesEvent extends AttendanceEvent {
  final AttendanceModel attendances;

  UpdateAttendancesEvent(this.attendances);

  @override
  List<Object?> get props => [attendances];
}

// class DeleteBatchEvent extends AttendanceEvent {
//   final int batchId;
//
//   DeleteBatchEvent(this.batchId);
//
//   @override
//   List<Object?> get props => [batchId];
// }

// class SearchBatchEvent extends AttendanceEvent {
//   final String query;
//
//   // final List<BatchModel> batches;
//   SearchBatchEvent(
//     this.query,
//   );

//   @override
//   List<Object?> get props => [
//         query,
//       ];
// }

//this is not used right now
// class GetBatchEvent extends BatchEvent {
//   final int batchId;

//   GetBatchEvent(this.batchId);

//   @override
//   List<Object?> get props => [batchId];
// }
