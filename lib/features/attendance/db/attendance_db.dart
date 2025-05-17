import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sems/features/attendance/attendance_model.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:sqflite/sqflite.dart';

class AttendanceDb {
  //here a private constructor is used to prevent instantiation of the class
  AttendanceDb._();

  static final AttendanceDb dbInstance = AttendanceDb._();
  static const tableName = 'attendance';
  static const dateCol = 'date';
  static const batchNameCol = 'batchName';
  static const batchIdCol = 'batchId';
  static const attendancesCol = 'attendances';
  static const createdAt = 'createdAt';

  // static const rollNoCol = 'rollNo';
  // static const attendanceStatus = 'attendanceStatus';

  Database? database;

  Future<bool> checkIfTableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [tableName]);

    return result.isNotEmpty;
  }

  Future<Database> getAttendanceDatabase() async {
// Check if database is null.
// If it is null, assign the result of await openDb() to database.
// If it is not null, keep its current value.
    database ??= await openDb();
    final isTableExists = await checkIfTableExists(database!, tableName);

    if (!isTableExists) {
      print("Table does not exist. Creating new table.");
      database = await openDb();
    }

    return database!;
  }

  Future<void> createTableIfNotExists(
      Database db, String createTableQuery) async {
    try {
      await db.execute(createTableQuery);
    } catch (e) {
      logger.e('Table creation failed: ${e.toString()}');
    }
  }

  Future<Database> openDb() async {
    try {
      final Directory appPath = await getApplicationDocumentsDirectory();
      final String dbPath = join(appPath.path, 'sems.db');

      final Database db = await openDatabase(dbPath, version: 1);

      // Check or create tables
      await createTableIfNotExists(db, '''
      CREATE TABLE IF NOT EXISTS $tableName (
        $dateCol TEXT,
        $attendancesCol TEXT,
        $batchIdCol TEXT,
        $createdAt TEXT,
        $batchNameCol TEXT  
      )
    ''');

      return db;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  // //this function is used for getting all the Courses from the database
  Future<AttendanceModel?> getAttendances(String date) async {
    final Database db = await getAttendanceDatabase();

    //this is same as select * from tableName
    // this will give me result as {course_name: courseName}
    final List<Map<String, dynamic>> rawAttendances =
        await db.query(tableName, where: '$dateCol =?', whereArgs: [date]);

    if (rawAttendances.isNotEmpty) {
      final AttendanceModel attendanceList =
          AttendanceModel.fromMap(rawAttendances.first);
      return attendanceList;
    }

    return null;
  }

  Future<int> addAttendances(AttendanceModel attendances) async {
    final Database db = await getAttendanceDatabase();
    int result = 0;
    final tempAttendance = await getAttendances(attendances.date);

    if (tempAttendance == null) {
      result = await db.insert(
        tableName,
        attendances.toMap(),
      );
    } else if (tempAttendance.date == attendances.date) {
      result = await updateAttendance(attendances);
    }

    logger.i('Attendance added : $result');
    // this db.insert will give the row affected int value
    return result;
  }

//
  Future<int> updateAttendance(AttendanceModel attendance) async {
    final Database db = await getAttendanceDatabase();

    final int result = await db.update(tableName, attendance.toMap(),
        where: '$dateCol =?', whereArgs: [attendance.date]);
    logger.i('Attendance day ${attendance.batchId} is updated : $result');

    // this db.insert will give the row affected int value
    return result;
  }
//
// Future<int> deleteBatch(int batchId) async {
//   final Database db = await getBatchDatabase();
//   return await db
//       .delete(tableName, where: '$batchIdCol =?', whereArgs: [batchId]);
// }
//
// Future<BatchModel> getBatch(int batchId) async {
//   final Database db = await getBatchDatabase();
//   final List<Map<String, dynamic>> rawBatchs = await db
//       .query(tableName, where: '$batchIdCol = ?', whereArgs: [batchId]);
//
//   if (rawBatchs.isEmpty) {
//     throw Exception('Batch not found');
//   }
//   final BatchModel batch = BatchModel.fromMap(rawBatchs.first);
//
//   return batch;
// }
}
