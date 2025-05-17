import 'package:sems/features/Todo/db/batch_db.dart';
import 'package:sems/features/Todo/todo_model.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/db/batch_db.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<TodoModel> batchList = [];
  TodoBloc() : super(TodoInitial()) {
    on<GettodoListEvent>(_getTodoList);
    on<AddTodoEvent>(_addTodo);
    on<DeleteTodoEvent>(_deleteBatch);
    // on<UpdateBatchEvent>(_updateBatch);
    // on<SearchBatchEvent>(_searchBatch);
  }

  void _getTodoList(GettodoListEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final TodoDb db = TodoDb.dbinstance;
      final List<TodoModel> tasks = await db.getTasks();

      batchList.addAll(tasks);

      logger.i('Todo fetched: $tasks');
      emit(TodoLoaded(tasks: tasks));
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      final TodoDb db = TodoDb.dbinstance;
      final int rowEffected = await db.addTask(event.task);

      if (rowEffected > 0) {
        emit(TaskAdded());

        //this is used here for fetching new batchs when added
        add(GettodoListEvent());
      }
    } catch (e) {
      logger.e(e.toString());
      emit(FailureState(message: e.toString()));
    }
  }

  void _deleteBatch(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      final TodoDb db = TodoDb.dbinstance;
      final int rowEffected = await db.deleteTask(event.taskId);

      if (rowEffected > 0) {
        batchList.clear();
        emit(TaskDeleted());
        add(GettodoListEvent());
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // void _updateBatch(UpdateBatchEvent event, Emitter<TodoState> emit) async {
  //   try {
  //     final BatchDb db = BatchDb.dbInstance;
  //     final int rowEffected = await db.updateBatch(event.batch);

  //     if (rowEffected > 0) {
  //       batchList.clear();
  //       emit(BatchEdited());
  //       add(GetBatchesListEvent());
  //     }
  //   } catch (e) {
  //     logger.e(e.toString());
  //   }
  // }

  // void _searchBatch(SearchBatchEvent event, Emitter<TodoState> emit) async {
  //   try {
  //     final String query = event.query.toLowerCase();

  //     // final List<BatchModel> batchs = (state as BatchLoaded).batches;

  //     logger.e('Query: $query Batchs fetched: $batchList');

  //     final List<BatchModel> searchedBatch = batchList.where((batch) {
  //       return batch.batchName.toLowerCase().contains(query);
  //     }).toList();

  //     logger.i('Query: $query Batchs fetched: $searchedBatch');

  //     if (searchedBatch.isNotEmpty) {
  //       emit(BatchLoaded(batches: searchedBatch)); // Emit if there are results
  //     } else {
  //       emit(const BatchLoaded(
  //           batches: [])); // Emit an empty list if no results are found
  //     }
  //   } catch (e) {
  //     logger.e(e.toString());
  //   }
  // }
}
