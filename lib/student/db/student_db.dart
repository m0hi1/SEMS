import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sems/student/model/student_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/utils/logger.dart';

class StudentDb {
  // Private constructor to prevent instantiation
  StudentDb._();

  static final StudentDb dbInstance = StudentDb._();
  static const tableName = 'students';

  // Column names for the students table
  static const acadmyIdCol = 'acadmyId';
  static const isActiveCol = 'isActive';
  static const studentIdCol = 'studentId';
  static const profileImageCol = 'profileImage';
  static const rollNumberCol = 'rollNumber';
  static const studentNameCol = 'studentName';
  static const guardianNameCol = 'guardianName';
  static const dateOfBirthCol = 'dateOfBirth';
  static const mobileNumber1Col = 'mobileNumber1';
  static const mobileNumber2Col = 'mobileNumber2';
  static const genderCol = 'gender';
  static const addressCol = 'address';
  static const batchNameCol = 'batchName';
  static const feeTypeCol = 'feeType';
  static const feeAmountCol = 'feeAmount';
  static const startDateCol = 'startDate';
  static const classOrSubjectCol = 'classOrSubject';
  static const schoolNameCol = 'schoolName';
  static const optionalField1Col = 'optionalField1';
  static const optionalField2Col = 'optionalField2';
  static const optionalField3Col = 'optionalField3';
  static const attachmentsCol = 'attachments';

  Database? _database;

  Future<Database> getStudentDatabase() async {
    _database ??= await _openDb(); // Efficiently open the database once
    return _database!;
  }

  Future<Database> _openDb() async {
    try {
      final Directory appPath = await getApplicationDocumentsDirectory();
      final String dbPath = join(appPath.path, 'sems.db');

      final Database db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        $acadmyIdCol TEXT,
        $isActiveCol INTEGER, // Use INTEGER for boolean values in SQLite
        $studentIdCol TEXT PRIMARY KEY,
        $profileImageCol BLOB,
        $rollNumberCol TEXT,
        $studentNameCol TEXT,
        $guardianNameCol TEXT,
        $dateOfBirthCol TEXT,
        $mobileNumber1Col TEXT,
        $mobileNumber2Col TEXT,
        $genderCol TEXT,
        $addressCol TEXT,
        $batchNameCol TEXT,
        $feeTypeCol TEXT,
        $feeAmountCol TEXT,
        $startDateCol TEXT,
        $classOrSubjectCol TEXT,
        $schoolNameCol TEXT,
        $optionalField1Col TEXT,
        $optionalField2Col TEXT,
        $optionalField3Col TEXT
        // $attachmentsCol TEXT // You might want to store attachments separately
      )
    ''');
        },
      );

      return db;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  // Add a new student to the database
  Future<int> addStudent(Student student) async {
    final Database db = await getStudentDatabase();
    return await db.insert(tableName, student.toMap());
  }

  // Get all students from the database
  Future<List<Student>> getStudents() async {
    final Database db = await getStudentDatabase();
    final List<Map<String, dynamic>> rawStudents = await db.query(tableName);
    return rawStudents.map((e) => Student.fromMap(e)).toList();
  }

  // Delete a student from the database
  Future<int> deleteStudent(String studentId) async {
    final Database db = await getStudentDatabase();
    return await db.delete(
      tableName,
      where: '$studentIdCol = ?',
      whereArgs: [studentId],
    );
  }

  Future<Student?> verifyStudentLogin({
    required String academyId,
    required String studentId,
    required String dateOfBirth,
  }) async {
    // 1. Check if student exists locally:
    final Database db = await getStudentDatabase();
    final localStudent =
        await _verifyStudentLocally(db, academyId, studentId, dateOfBirth);

    if (localStudent != null) {
      return localStudent; // Found locally
    } else {
      // 2. Student not found locally, query Firestore:
      try {
        final studentDoc = await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .get();

        if (studentDoc.exists) {
          final studentData = studentDoc.data() as Map<String, dynamic>;
          if (studentData['academyId'] == academyId &&
              studentData['dateOfBirth'] == dateOfBirth) {
            // Validated against Firestore
            final newStudent = Student.fromMap(studentData);
            await addStudent(
                newStudent); // Add to local DB for faster future logins
            return newStudent;
          }
        }
      } catch (e) {
        logger.e('Firestore login verification error: $e');
      }
    }

    return null; // No matching student found
  }

  Future<Student?> _verifyStudentLocally(Database db, String academyId,
      String studentId, String dateOfBirth) async {
    try {
      final List<Map<String, dynamic>> result = await db.query(
        tableName,
        where: '''
          $acadmyIdCol = ? AND 
          $studentIdCol = ? AND 
          $dateOfBirthCol = ? AND 
          $isActiveCol = ?
        ''',
        whereArgs: [academyId, studentId, dateOfBirth, 1],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return Student.fromMap(result.first);
      }
      return null;
    } catch (e) {
      logger.e('Login verification error: $e');
      return null;
    }
  }
}
