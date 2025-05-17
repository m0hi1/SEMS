import 'package:sems/auth/bloc/student_auth_bloc.dart';
import 'package:sems/features/attendance/bloc/attendance_bloc.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:sems/profile/views/profile_screen.dart';
import 'package:sems/shared/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sems/student/db/student_db.dart';
import 'package:sqflite/sqflite.dart';
import 'auth/bloc/auth_bloc.dart';
import 'core/bloc/theme/theme_bloc.dart';
import 'router.dart';
import 'core/network/firebase_options.dart';
import 'features/Todo/bloc/todo_bloc.dart';
import 'profile/cubit/profile_cubit.dart';
import 'sems_app.dart';
import 'student/bloc/attachment_bloc.dart';
import 'student/bloc/student_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  await Hive.openBox('authBox');

  runApp(MultiBlocProvider(
    providers: [
        

      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider<AttendanceBloc>(
        create: (context) => AttendanceBloc(),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc()
          ..add(
            CheckAuthStatus(),
          ),
      ),
      BlocProvider<FirestoreDataCubit>(
        create: (context) => FirestoreDataCubit(context.read<AuthBloc>()),
        // child: const ProfileScreen(),
      ),
      BlocProvider<BatchBloc>(
        create: (context) => BatchBloc()
          ..add(
            GetBatchesListEvent(),
          ),
      ),
      BlocProvider<AttachmentBloc>(
        create: (context) => AttachmentBloc(),
      ),
      BlocProvider<StudentBloc>(
          create: (context) => StudentBloc(db: StudentDb.dbInstance)
            ..add(
              GetStudentListEvent(),
            )),
      BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()
          ..add(
            GettodoListEvent(),
          ),
      ),
      
      BlocProvider<StudentAuthBloc>(
        create: (context) => StudentAuthBloc(
          studentDb: StudentDb.dbInstance,
        ),
      )
    ],

    child: const MainApp(),
  ));
}
