import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CourseDb {
  //here a private constructor is used to prevent instantiation of the class
  CourseDb._();

  static final CourseDb dbInstance = CourseDb._();
  static const tableName = 'courses';
  static const courseNameCol = 'course_name';

  Database? database;

  Future<Database> getCourseDatabase() async {
    if (database != null) {
      return database!;
    } else {
      database = await openDb();
      return database!;
    }
  }

  Future<Database> openDb() async {
    //here we get the path of the document directory in the device
    try {
      final Directory appPath = await getApplicationDocumentsDirectory();
      //here we join the paths of the document directory and the database com.example.course.db like this
      final String dbPath = join(appPath.path, 'course.db');

      final Database db =
          await openDatabase(dbPath, version: 1, onCreate: (db, version) {
        //here we create the table in the database
        db.execute(
            'CREATE TABLE $tableName ($courseNameCol TEXT PRIMARY KEY )');
      });

      return db;
    } on DatabaseException catch (e) {
      print(e.toString());
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  //this function is used for adding a course to the database
  Future<bool> addCourse(
    String courseName,
  ) async {
    final Database db = await getCourseDatabase();

    //here this function will return rows affected by the query

    int rowsEffected = await db.insert(tableName, {
      courseNameCol: courseName,
    });

    //this will check if any row effected or not
    return rowsEffected > 0;
  }

  //this function is used for getting all the Courses from the database
  Future<List<String>> getCourses() async {
    final Database db = await getCourseDatabase();

    try {
      //this is same as select * from tableName
      // this will give me result as {course_name: courseName}
      final List<Map<String, dynamic>> students = await db.query(tableName);

      final List<String> courses = students
          .map((e) => e[courseNameCol].toString())
          .toList(); //this will give me result as [courseName]

      print(students);
      return courses;
    } on DatabaseException catch (e) {
      print(e.toString());
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }

    //this is same as select * from tableName
  }

  //this function is used for deleting a Course from the database
  Future<bool> deleteCourse(String courseName) async {
    final Database db = await getCourseDatabase();
    int rowsEffected = await db.delete(tableName,
        where: '$courseNameCol = ?', whereArgs: [courseName]);
    return rowsEffected > 0;
  }
}
