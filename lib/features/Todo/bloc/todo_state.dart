part of 'todo_bloc.dart';

//sealed means it can't be accessed outside the file
sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

//initial state
final class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

//loading state
final class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

//error state
final class FailureState extends TodoState {
  final String message;
  const FailureState({required this.message});
  @override
  List<Object> get props => [message];
}

//this used for getting the notes
final class TodoLoaded extends TodoState {
  final List<TodoModel> tasks;
  const TodoLoaded({required this.tasks});
  @override
  List<Object> get props => [tasks];
}

final class GetTodoById extends TodoState {
  final BatchModel task;
  const GetTodoById({required this.task});
  @override
  List<Object> get props => [task];
}

// final class BatchEdited extends TodoState {
//   @override
//   List<Object> get props => [];
// }

final class TaskDeleted extends TodoState {
  @override
  List<Object> get props => [];
}

final class TaskAdded extends TodoState {
  @override
  List<Object> get props => [];
}
