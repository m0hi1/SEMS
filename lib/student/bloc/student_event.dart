part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {}

class GetStudentListEvent extends StudentEvent {
  @override
  List<Object?> get props => [];
}

class GetFilteredStudentListEvent extends StudentEvent {
  final String batch;
  final bool? isActive;
  GetFilteredStudentListEvent({required this.batch, this.isActive});
  @override
  List<Object?> get props => [batch];
}

class GetSearchedStudentListEvent extends StudentEvent {
  final String studentName;
  final bool? isActive;
  GetSearchedStudentListEvent({required this.studentName, this.isActive});
  @override
  List<Object?> get props => [studentName];
}

class AddStudentEvent extends StudentEvent {
  final Student student;
  AddStudentEvent(this.student);
  @override
  List<Object?> get props => [student];
}

// class UpdateBatchEvent extends StudentEvent {
//   final BatchModel batch;
//   UpdateBatchEvent(this.batch);

//   @override
//   List<Object?> get props => [batch];
// }

// class DeleteBatchEvent extends StudentEvent {
//   final int batchId;
//   DeleteBatchEvent(this.batchId);

//   @override
//   List<Object?> get props => [batchId];
// }

// class SearchBatchEvent extends StudentEvent {
//   final String query;
//   // final List<BatchModel> batches;
//   SearchBatchEvent(
//     this.query,
//   );

//   @override
//   List<Object?> get props => [
//         query,
//       ];
// }





