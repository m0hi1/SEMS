import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sems/features/attendance/attendance_model.dart';
import 'package:sems/features/attendance/db/attendance_db.dart';
import 'package:sems/shared/utils/logger.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final List<AttendanceModel?> attendancesList = [];

  AttendanceBloc() : super(AttendanceInitial()) {
    on<GetAttendancesEvent>(_getAttendancesList);
    on<AddAttendancesEvent>(_addAttendances);
    // on<DeleteBatchEvent>(_deleteBatch);
    // on<UpdateBatchEvent>(_updateBatch);
    // on<SearchBatchEvent>(_searchBatch);
  }

  void _getAttendancesList(
      GetAttendancesEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final AttendanceDb db = AttendanceDb.dbInstance;
      final AttendanceModel? attendances = await db.getAttendances(event.date);
      attendancesList.add(attendances);

      logger.i('attendances fetched: $attendances');
      if (attendances != null) {
        emit(AttendanceLoaded(attendance: attendances));
      } else {
        emit(AttendanceInitial());
      }
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _addAttendances(
      AddAttendancesEvent event, Emitter<AttendanceState> emit) async {
    try {
      final AttendanceDb db = AttendanceDb.dbInstance;
      final int rowEffected = await db.addAttendances(event.attendances);

      if (rowEffected > 0) {
        emit(AttendancesAdded());

        //this is used here for fetching new batchs when added
        add(GetAttendancesEvent(event.attendances.date));
      }
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

//   void _deleteBatch(
//       DeleteBatchEvent event, Emitter<AttendanceState> emit) async {
//     try {
//       final BatchDb db = BatchDb.dbInstance;
//       final int rowEffected = await db.deleteBatch(event.batchId);
//
//       if (rowEffected > 0) {
//         batchList.clear();
//         emit(BatchDeleted());
//         add(GetBatchesListEvent());
//       }
//     } catch (e) {
//       logger.e(e.toString());
//     }
//   }
//
//   void _updateBatch(
//       UpdateBatchEvent event, Emitter<AttendanceState> emit) async {
//     try {
//       final BatchDb db = BatchDb.dbInstance;
//       final int rowEffected = await db.updateBatch(event.batch);
//
//       if (rowEffected > 0) {
//         batchList.clear();
//         emit(BatchEdited());
//         add(GetBatchesListEvent());
//       }
//     } catch (e) {
//       logger.e(e.toString());
//     }
//   }
//
//   void _searchBatch(
//       SearchBatchEvent event, Emitter<AttendanceState> emit) async {
//     try {
//       final String query = event.query.toLowerCase();
//
//       // final List<BatchModel> batchs = (state as BatchLoaded).batches;
//
//       final List<BatchModel> searchedBatch = batchList.where((batch) {
//         return batch.batchName.toLowerCase().contains(query);
//       }).toList();
//
//       logger.i('Query: $query Batchs fetched: $searchedBatch');
//
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
}
