part of 'attachment_bloc.dart';

sealed class AttachmentEvent extends Equatable {}

class GetAttachmentsByIdEvent extends AttachmentEvent {
  final String studentId;
  GetAttachmentsByIdEvent(this.studentId);
  @override
  List<Object?> get props => [studentId];
}

class AddAttachmentEvent extends AttachmentEvent {
  final AttachmentsModel attachment;
  AddAttachmentEvent(this.attachment);
  @override
  List<Object?> get props => [attachment];
}

// class UpdateBatchEvent extends AttachmentEvent {
//   final BatchModel batch;
//   UpdateBatchEvent(this.batch);

//   @override
//   List<Object?> get props => [batch];
// }

class DeleteAttachmentEvent extends AttachmentEvent {
  final String documentId;
  final String studentId;
  DeleteAttachmentEvent(this.documentId, this.studentId);

  @override
  List<Object?> get props => [documentId, studentId];
}

// class SearchBatchEvent extends AttachmentEvent {
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





