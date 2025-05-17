import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/db/batch_db.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final List<BatchModel> batchList = [];
  BatchBloc() : super(BatchInitial()) {
    on<GetBatchesListEvent>(_getBatchesList);
    on<AddBatchEvent>(_addBatch);
    on<DeleteBatchEvent>(_deleteBatch);
    on<UpdateBatchEvent>(_updateBatch);
    on<SearchBatchEvent>(_searchBatch);
  }

  void _getBatchesList(
      GetBatchesListEvent event, Emitter<BatchState> emit) async {
    emit(BatchLoading());
    try {
      final BatchDb db = BatchDb.dbInstance;
      final List<BatchModel> batches = await db.getBatchs();

      batchList.addAll(batches);

      logger.i('Batchs fetched: $batches');
      emit(BatchLoaded(batches: batches));
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _addBatch(AddBatchEvent event, Emitter<BatchState> emit) async {
    try {
      final BatchDb db = BatchDb.dbInstance;
      final int rowEffected = await db.addBatchs(event.batch);

      if (rowEffected > 0) {
        emit(BatchAdded());

        //this is used here for fetching new batchs when added
        add(GetBatchesListEvent());
      }
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _deleteBatch(DeleteBatchEvent event, Emitter<BatchState> emit) async {
    try {
      final BatchDb db = BatchDb.dbInstance;
      final int rowEffected = await db.deleteBatch(event.batchId);

      if (rowEffected > 0) {
        batchList.clear();
        emit(BatchDeleted());
        add(GetBatchesListEvent());
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void _updateBatch(UpdateBatchEvent event, Emitter<BatchState> emit) async {
    try {
      final BatchDb db = BatchDb.dbInstance;
      final int rowEffected = await db.updateBatch(event.batch);

      if (rowEffected > 0) {
        batchList.clear();
        emit(BatchEdited());
        add(GetBatchesListEvent());
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void _searchBatch(SearchBatchEvent event, Emitter<BatchState> emit) async {
    try {
      final String query = event.query.toLowerCase();

      // final List<BatchModel> batchs = (state as BatchLoaded).batches;

      final List<BatchModel> searchedBatch = batchList.where((batch) {
        return batch.batchName.toLowerCase().contains(query);
      }).toList();

      logger.i('Query: $query Batchs fetched: $searchedBatch');

      if (searchedBatch.isNotEmpty) {
        emit(BatchLoaded(batches: searchedBatch)); // Emit if there are results
      } else {
        emit(const BatchLoaded(
            batches: [])); // Emit an empty list if no results are found
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
