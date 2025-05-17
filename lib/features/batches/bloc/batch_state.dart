part of 'batch_bloc.dart';

//sealed means it can't be accessed outside the file
sealed class BatchState extends Equatable {
  const BatchState();

  @override
  List<Object> get props => [];
}

//initial state
final class BatchInitial extends BatchState {
  @override
  List<Object> get props => [];
}

//loading state
final class BatchLoading extends BatchState {
  @override
  List<Object> get props => [];
}

//error state
final class FailureState extends BatchState {
  final String message;
  const FailureState({required this.message});
  @override
  List<Object> get props => [message];
}

//this used for getting the notes
final class BatchLoaded extends BatchState {
  final List<BatchModel> batches;
  const BatchLoaded({required this.batches});
  @override
  List<Object> get props => [batches];
}

final class GetBatchById extends BatchState {
  final BatchModel batch;
  const GetBatchById({required this.batch});
  @override
  List<Object> get props => [batch];
}

final class BatchEdited extends BatchState {
  @override
  List<Object> get props => [];
}

final class BatchDeleted extends BatchState {
  @override
  List<Object> get props => [];
}

final class BatchAdded extends BatchState {
  @override
  List<Object> get props => [];
}
