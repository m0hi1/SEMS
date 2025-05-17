import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../shared/utils/logger.dart';
import '../db/attachment_db.dart';
import '../views/attachments_model.dart';

part 'attachment_event.dart';
part 'attachment_state.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  final List<AttachmentsModel> attachmentList = [];
  AttachmentBloc() : super(AttachmentInitial()) {
    on<GetAttachmentsByIdEvent>(_getAttachmentListById);
    on<AddAttachmentEvent>(_addAttachment);
    on<DeleteAttachmentEvent>(_deleteAttachment);
    // on<UpdateStudentEvent>(_updateBatch);
    // on<SearchStudentEvent>(_searchBatch);
  }

  void _getAttachmentListById(
      GetAttachmentsByIdEvent event, Emitter<AttachmentState> emit) async {
    emit(AttachmentLoading());
    try {
      final AttachmentDb db = AttachmentDb.dbInstance;
      final List<AttachmentsModel> attachments =
          await db.getAttachmentsById(event.studentId);

      attachmentList.addAll(attachments);

      emit(AttachmentLoaded(attachments: attachments));
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _addAttachment(
      AddAttachmentEvent event, Emitter<AttachmentState> emit) async {
    try {
      final AttachmentDb db = AttachmentDb.dbInstance;
      final int rowEffected = await db.addAttachments(event.attachment);

      if (rowEffected > 0) {
        emit(AttachmentAdded());
        logger.i('attachment added: $rowEffected');

        //this is used here for fetching new batchs when added
        add(GetAttachmentsByIdEvent(event.attachment.studentId));
      }
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _deleteAttachment(
      DeleteAttachmentEvent event, Emitter<AttachmentState> emit) async {
    try {
      final AttachmentDb db = AttachmentDb.dbInstance;
      final int rowEffected = await db.deleteAttachments(event.documentId);

      if (rowEffected > 0) {
        attachmentList.clear();
        emit(AttachmentDeleted());
        add(GetAttachmentsByIdEvent(event.studentId));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

//   void _updateBatch(UpdateBatchEvent event, Emitter<BatchState> emit) async {
//     try {
//       final BatchDb db = BatchDb.dbInstance;
//       final int rowEffected = await db.updateBatch(event.batch);

//       if (rowEffected > 0) {
//         batchList.clear();
//         emit(BatchEdited());
//         add(GetBatchesListEvent());
//       }
//     } catch (e) {
//       logger.e(e.toString());
//     }
//   }

//   void _searchBatch(SearchBatchEvent event, Emitter<BatchState> emit) async {
//     try {
//       final String query = event.query.toLowerCase();

//       // final List<BatchModel> batchs = (state as BatchLoaded).batches;

//       logger.e('Query: $query Batchs fetched: $batchList');

//       final List<BatchModel> searchedBatch = batchList.where((batch) {
//         return batch.batchName.toLowerCase().contains(query);
//       }).toList();

//       logger.i('Query: $query Batchs fetched: $searchedBatch');

//       if (searchedBatch.isNotEmpty) {
//         emit(BatchLoaded(batches: searchedBatch)); // Emit if there are results
//       } else {
//         emit(const BatchLoaded(
//             batches: [])); // Emit an empty list if no results are found
//       }
//     } catch (e) {
//       logger.e(e.toString());
//     }
//   }
// }
}
