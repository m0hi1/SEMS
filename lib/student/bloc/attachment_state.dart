part of 'attachment_bloc.dart';

//sealed means it can't be accessed outside the file

// import 'package:equatable/equatable.dart';

sealed class AttachmentState extends Equatable {
  const AttachmentState();

  @override
  List<Object> get props => [];
}

//initial state
final class AttachmentInitial extends AttachmentState {
  @override
  List<Object> get props => [];
}

//loading state
final class AttachmentLoading extends AttachmentState {
  @override
  List<Object> get props => [];
}

//error state
final class FailureState extends AttachmentState {
  final String message;
  const FailureState({required this.message});
  @override
  List<Object> get props => [message];
}

//this used for getting the notes
final class AttachmentLoaded extends AttachmentState {
  final List<AttachmentsModel> attachments;
  const AttachmentLoaded({required this.attachments});
  @override
  List<Object> get props => [attachments];
}

// final class GetAttachmentById extends AttachmentState {
//   final AttachmentsModel attachments;
//   const GetAttachmentById({required this.attachments});
//   @override
//   List<Object> get props => [attachments];
// }

// final class AttachmentEdited extends AttachmentState {
//   @override
//   List<Object> get props => [];
// }

final class AttachmentDeleted extends AttachmentState {
  @override
  List<Object> get props => [];
}

final class AttachmentAdded extends AttachmentState {
  @override
  List<Object> get props => [];
}
