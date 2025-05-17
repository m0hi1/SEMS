import 'dart:io';
import 'package:sems/features/Todo/todo_model.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDb {
  TodoDb._(); // Private constructor for singleton pattern

  static final TodoDb dbinstance = TodoDb._();
  static const String tableName = 'todo';
  static const String taskIdCol = 'taskId';
  static const String taskDescriptionCol = 'taskDescription';
  static const String remarksCol = 'remarks';
  static const String priorityCol = 'priority';
  static const String dueDateCol = 'dueDate';
  static const String dueTimeCol = 'dueTime';
  static const String repeatCol = 'repeat';
  static const String taskTypeCol = 'taskType';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    Directory appPath = await getApplicationDocumentsDirectory();
    String dbPath = join(appPath.path, 'todo.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $tableName (
            $taskIdCol INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskDescriptionCol TEXT,
            $remarksCol TEXT,
            $priorityCol TEXT,
            $dueDateCol TEXT,
            $dueTimeCol TEXT,
            $repeatCol TEXT,
            $taskTypeCol TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> addTask(TodoModel task) async {
    final db = await database;
    return await db.insert(tableName, task.toMap());
  }

  Future<List<TodoModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> rawTasks = await db.query(tableName);
    return rawTasks.map((map) => TodoModel.fromMap(map)).toList();
  }

  Future<int> deleteTask(int taskId) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: '$taskIdCol = ?',
      whereArgs: [taskId],
    );
  }

  Future<TodoModel?> getTask(int taskId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$taskIdCol = ?',
      whereArgs: [taskId],
    );

    if (maps.isNotEmpty) {
      return TodoModel.fromMap(maps.first);
    } else {
      logger.e('Task not found');
      return null;
    }
  }
}
