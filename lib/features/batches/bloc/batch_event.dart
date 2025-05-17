part of 'batch_bloc.dart';

sealed class BatchEvent extends Equatable {}

class GetBatchesListEvent extends BatchEvent {
  @override
  List<Object?> get props => [];
}

class AddBatchEvent extends BatchEvent {
  final BatchModel batch;
  AddBatchEvent(this.batch);
  @override
  List<Object?> get props => [batch];
}

class UpdateBatchEvent extends BatchEvent {
  final BatchModel batch;
  UpdateBatchEvent(this.batch);

  @override
  List<Object?> get props => [batch];
}

class DeleteBatchEvent extends BatchEvent {
  final int batchId;
  DeleteBatchEvent(this.batchId);

  @override
  List<Object?> get props => [batchId];
}

class SearchBatchEvent extends BatchEvent {
  final String query;
  // final List<BatchModel> batches;
  SearchBatchEvent(
    this.query,
  );

  @override
  List<Object?> get props => [
        query,
      ];
}







//this is not used right now
// class GetBatchEvent extends BatchEvent {
//   final int batchId;

//   GetBatchEvent(this.batchId);

//   @override
//   List<Object?> get props => [batchId];
// }