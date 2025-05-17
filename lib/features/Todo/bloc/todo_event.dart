part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {}

class GettodoListEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final TodoModel task;
  AddTodoEvent(this.task);
  @override
  List<Object?> get props => [task];
}

// class UpdateBatchEvent extends TodoEvent {
//   final BatchModel batch;
//   UpdateBatchEvent(this.batch);

//   @override
//   List<Object?> get props => [batch];
// }

class DeleteTodoEvent extends TodoEvent {
  final int taskId;
  DeleteTodoEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

// class SearchBatchEvent extends TodoEvent {
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







//this is not used right now
// class GetBatchEvent extends BatchEvent {
//   final int batchId;

//   GetBatchEvent(this.batchId);

//   @override
//   List<Object?> get props => [batchId];
// }