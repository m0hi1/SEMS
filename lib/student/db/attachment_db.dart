import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/utils/logger.dart';
import '../views/attachments_model.dart';

class AttachmentDb {
  //here a private constructor is used to prevent instantiation of the class
  AttachmentDb._();

  static final AttachmentDb dbInstance = AttachmentDb._();
  static const tableName = 'attachments';

  //these are all the fields of the table
  static const documentIdCol = 'documentId';
  static const studentIdCol = 'studentId';
  static const nameCol = 'name';
  static const imageCol = 'image';

  Database? database;

  Future<bool> checkIfTableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [tableName]);

    return result.isNotEmpty;
  }

  Future<Database> getAttachmentsDatabase() async {
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
        $documentIdCol TEXT PRIMARY KEY,
        $studentIdCol TEXT,
        $nameCol TEXT,
        $imageCol BLOB,
       
      )
    ''');

      return db;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  //this function is used for adding a Students to the database
  Future<int> addAttachments(AttachmentsModel attachment) async {
    final Database db = await getAttachmentsDatabase();

    //here this function will return rows affected by the query

    int rowsEffected = await db.insert(
      tableName, attachment.toMap(),
      // conflictAlgorithm: ConflictAlgorithm.replace
    );

    //this will check if any row effected or not
    return rowsEffected;
  }

  //this function is used for getting all the students from the database
  Future<List<AttachmentsModel>> getAttachmentsById(String studentId) async {
    final Database db = await getAttachmentsDatabase();

    //this is same as select * from tableName
    final List<Map<String, dynamic>> rawAttachments = await db
        .query(tableName, where: '$studentIdCol = ?', whereArgs: [studentId]);

    final List<AttachmentsModel> attachmentList =
        rawAttachments.map((e) => AttachmentsModel.fromMap(e)).toList();

    return attachmentList;
  }
  //this is same as select * from tableName

// this function is used for deleting a student from the database
  Future<int> deleteAttachments(String documentId) async {
    final Database db = await getAttachmentsDatabase();
    int rowsEffected = await db.delete(tableName,
        where: '$documentIdCol = ?', whereArgs: [documentId]);
    return rowsEffected;
  }
}
