import 'dart:io';

import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BatchDb {
  //here a private constructor is used to prevent instantiation of the class
  BatchDb._();

  static final BatchDb dbInstance = BatchDb._();
  static const tableName = 'batchs';
  static const batchIdCol = 'batchId';
  static const batchnameCol = 'batchName';
  static const isActiveCol = 'isActive';
  static const batchAdminCol = 'batchAdmin';
  static const batchTimeCol = 'batchTime';
  static const batchDaysCol = 'batchDays';
  static const batchLocationCol = 'batchLocation';
  static const batchMaximumSlotsCol = 'batchMaximumSlots';
  static const batchCreatedAtCol = 'createdAt';

  Database? database;

  Future<bool> checkIfTableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [tableName]);

    return result.isNotEmpty;
  }

  Future<Database> getBatchDatabase() async {
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
        $batchIdCol INTEGER PRIMARY KEY AUTOINCREMENT,
        $batchnameCol TEXT,
        $isActiveCol TEXT,
        $batchAdminCol TEXT,
        $batchTimeCol TEXT,
        $batchDaysCol TEXT,
        $batchLocationCol TEXT,
        $batchMaximumSlotsCol INTEGER,
        $batchCreatedAtCol TEXT
        
      )
    ''');

      return db;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  //this function is used for adding a course to the database
  // Future<bool> addBatch(
  //   String courseName,
  // ) async {
  //   final Database db = await getBatchDatabase();

  //   //here this function will return rows affected by the query

  //   int rowsEffected = await db.insert(tableName, {
  //     courseNameCol: courseName,
  //   });

  //   //this will check if any row effected or not
  //   return rowsEffected > 0;
  // }

  // //this function is used for getting all the Courses from the database
  Future<List<BatchModel>> getBatchs() async {
    final Database db = await getBatchDatabase();

    //this is same as select * from tableName
    // this will give me result as {course_name: courseName}
    final List<Map<String, dynamic>> rawBatchs = await db.query(tableName);
    final List<BatchModel> batchList =
        rawBatchs.map((e) => BatchModel.fromMap(e)).toList();

    logger.i('Batchs fetched: $batchList');
    return batchList;
  }

  Future<int> addBatchs(BatchModel batch) async {
    final Database db = await getBatchDatabase();
    final int result = await db.insert(
      tableName,
      batch.toMap(),
    );
    logger.i('Batch added : $result');
    // this db.insert will give the row affected int value
    return result;
  }

  Future<int> updateBatch(BatchModel batch) async {
    final Database db = await getBatchDatabase();
    logger.i('Batch ${batch.batchId} ');

    final int result = await db.update(tableName, batch.toMap(),
        where: '$batchIdCol =?', whereArgs: [batch.batchId]);
    logger.i('Batch ${batch.batchId} updated : $result');

    // this db.insert will give the row affected int value
    return result;
  }

  Future<int> deleteBatch(int batchId) async {
    final Database db = await getBatchDatabase();
    return await db
        .delete(tableName, where: '$batchIdCol =?', whereArgs: [batchId]);
  }

  Future<BatchModel> getBatch(int batchId) async {
    final Database db = await getBatchDatabase();
    final List<Map<String, dynamic>> rawBatchs = await db
        .query(tableName, where: '$batchIdCol = ?', whereArgs: [batchId]);

    if (rawBatchs.isEmpty) {
      throw Exception('Batch not found');
    }
    final BatchModel batch = BatchModel.fromMap(rawBatchs.first);

    return batch;
  }
}
