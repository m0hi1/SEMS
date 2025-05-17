import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/admin/views/admin_home.dart';
import 'package:sems/admin/views/refferal_screen.dart';
import 'package:sems/features/attendance/take_Attendence_view.dart';
import 'package:sems/features/batches/batches_list.dart';
import 'package:sems/features/onboarding/spash_screen.dart';
import 'package:sems/shared/pages/settings_screen.dart';
import 'package:sems/student/views/student_home.dart';
import 'package:sems/student/views/study_material.dart';
import 'package:sems/student/views/view_attendence_screen.dart';

import 'admin/utils/upload_material.dart';
import 'admin/views/about.dart';
import 'admin/views/bottom_dashboard.dart';
import 'admin/views/help_screen.dart';
import 'ai/view/sems_ai_assistant.dart';
import 'auth/views/admin_google_login.dart';
import 'auth/views/admin_resgister.dart';
import 'auth/views/role_selection_signin.dart';
import 'auth/views/student_login.dart';
import 'features/Todo/newtask.dart';
import 'features/Todo/todo_home.dart';
import 'features/attendance/attendance_page.dart';
import 'features/batches/batch_model.dart';
import 'features/batches/new_batch.dart';
import 'features/courses/add_courses_page.dart';
import 'features/notifications/notifications_screen.dart';
import 'features/onboarding/introduction_screen.dart';
import 'features/scanner/qr_scanner.dart';
import 'features/teachers/subscription/subscription_page.dart';
import 'features/tution fees/tution_fees_page.dart';
import 'profile/model/user_data.dart';
import 'profile/views/profile_screen.dart';
import 'profile/views/profile_update_screen.dart';
import 'student/views/active_students_list.dart';
import 'student/views/add_student_page.dart';
import 'student/views/my_academy.dart';
import 'student/views/student_options_page.dart';
import 'student/views/tuition_fee.dart';

// AppRoute enum with path getters
enum AppRoute {
  splash('/'),
  welcome('/welcome'),
  roleSelection('/role-selection'),
  login('/login'),
  register('/register'),
  studentLogin('/login-student'),
  teacherLogin('/login-teacher'),
  adminLogin('/login-admin'),
  home('/home'),
  profile('/profile'),
  profileUpdate('/profile-update'),
  adminHome('/admin-home'),
  studentHome('/student-home'),
  teacherHome('/teacher-home'),
  manageClasses('/manage-classes'),
  manageCourses('/manage-courses'),
  manageStudents('/manage-students'),
  generateTests('/generate-tests'),
  publishResults('/publish-results'),
  postNotes('/post-notes'),
  viewReports('/view-reports'),
  viewAttendance('/view-attendance'),
  accessMaterials('/course-materials'),
  takeTests('/take-tests'),
  viewResults('/view-results'),
  notifications('/notifications'),
  createAssignments('/create-assignments'),
  gradeTests('/grade-tests'),
  provideFeedback('/provide-feedback'),
  activeStudentsList('/active-students-list'),
  scanner('/scanner'),
  attendance('/attendance'),
  takeAttendance('/take-attendance'),
  tutionfees('/tution-fees'),
  courses('/courses'),
  studentOptions('/student-options'),
  addStudent('/add-student'),
  batchList('/batch-list'),
  referral('/referral'),
  about('/about'),
  academyScreen('/academy-screen'),
  todohome('/todo-home'),
  todonewtask('/todo-new-task'),
  help('/help'),
  newBatch('/new-batch'),
  subscriptionPlans('/subscription-plans'),
  studenttutionfees('/student-fees'),
  studyMaterial('/study-material'),
  uploadMaterial('/upload-material'),
  semsAiAssistant('/sems-ai-assistant'),
  setting('/setting');

  const AppRoute(this.path);

  final String path;
}

class AppRouter {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static final GoRouter router = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: AppRoute.splash.path,
    routes: _buildAppRoute(),
    errorBuilder: _errorBuilder,
    // refreshListenable: GoRouterRefreshStream(AuthBloc()),
  );

  static List<RouteBase> _buildAppRoute() => [
        GoRoute(
          path: AppRoute.splash.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoute.welcome.path,
          builder: (context, state) => const MyIntroductionScreen(),
        ),
        GoRoute(
          path: AppRoute.roleSelection.path,
          builder: (context, state) => const RoleSelectionScreen(),
        ),
        GoRoute(
          path: AppRoute.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
          
        GoRoute(
          path: AppRoute.register.path,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return RegisterScreen(
              uid: extra['uid'],
              email: extra['email'],
              name: extra['name'],
            );
          },
        ),
        GoRoute(
          path: AppRoute.studentLogin.path,
          builder: (context, state) => LoginStudentScreen(),
        ),

        // Admin AppRoute
        GoRoute(
          path: AppRoute.adminHome.path,
          builder: (context, state) => const AdminHome(),
        ),
        GoRoute(
          path: AppRoute.manageClasses.path,
          builder: (context, state) => const BatchesList(),
        ),

        GoRoute(
            path: AppRoute.home.path,
            builder: (context, state) {
              return const MyAppBottomBar();
            }),

        GoRoute(
          path: AppRoute.profileUpdate.path,
          builder: (context, state) => ProfileUpdateScreen(
            userData: state.extra as UserData,
          ),
        ),
        GoRoute(
          path: AppRoute.activeStudentsList.path,
          builder: (context, state) => const ActiveStudentsList(),
        ),
        GoRoute(
          path: AppRoute.scanner.path,
          builder: (context, state) => const QrScannerScreen(),
        ),
        GoRoute(
          path: AppRoute.attendance.path,
          builder: (context, state) => const AttendancePage(),
        ),
        GoRoute(
          path: AppRoute.takeAttendance.path,
          builder: (context, state) => TakeAttendanceScreen(
            batch: state.extra as BatchModel,
          ),
        ),
        GoRoute(
          path: AppRoute.tutionfees.path,
          builder: (context, state) => const TutionFeesPage(),
        ),
        GoRoute(
          path: AppRoute.courses.path,
          builder: (context, state) => const AddCoursesPage(),
        ),
        GoRoute(
          path: AppRoute.studentOptions.path,
          builder: (context, state) => const StudentOptionsPage(),
        ),
        GoRoute(
          path: AppRoute.addStudent.path,
          builder: (context, state) => const AddStudentPage(),
        ),
        GoRoute(
          path: AppRoute.batchList.path,
          builder: (context, state) => const BatchesList(),
        ),
        GoRoute(
          path: AppRoute.referral.path,
          builder: (context, state) => const ReferralScreen(),
        ),
        GoRoute(
          path: AppRoute.about.path,
          builder: (context, state) => const About(),
        ),
        GoRoute(
          path: AppRoute.academyScreen.path,
          builder: (context, state) => const MyAcademyScreen(),
        ),
        GoRoute(
          path: AppRoute.todohome.path,
          builder: (context, state) => const todoHome(),
        ),
        GoRoute(
          path: AppRoute.todonewtask.path,
          builder: (context, state) => const NewTask(),
        ),
        GoRoute(
          path: AppRoute.help.path,
          builder: (context, state) => const HelpScreen(),
        ),
        GoRoute(
          path: AppRoute.newBatch.path,
          builder: (context, state) {
            if (state.extra != null) {
              final BatchModel batch = state.extra as BatchModel;
              return NewBatch(batch: batch);
            } else {
              return const NewBatch();
            }
            // print(batch.batchName);
          },
        ),
        GoRoute(
          path: AppRoute.subscriptionPlans.path,
          builder: (context, state) => SubscriptionList(),
        ),
        GoRoute(
          path: AppRoute.semsAiAssistant.path,
          builder: (context, state) => const SemsAiAssistant(),
        ),

        // Student AppRoute
        GoRoute(
          path: AppRoute.studentHome.path,
          builder: (context, state) => const StudentHome(),
        ),
        GoRoute(
          path: AppRoute.viewAttendance.path,
          builder: (context, state) => const ViewAttendenceScreen(),
        ),
        GoRoute(
            path: AppRoute.studenttutionfees.path,
            builder: (context, state) => StudentTuitionFeeScreen()),
        GoRoute(
          path: AppRoute.studyMaterial.path,
          builder: (context, state) => StudyMaterialsScreen(),
        ),
        // Teacher AppRoute
        GoRoute(
            path: AppRoute.uploadMaterial.path,
            builder: (context, state) => UploadMaterialScreen()),
        // GoRoute(
        //   path: AppRoute.teacherHome.path,
        //   builder: (context, state) => const TeacherHomeScreen(),
        // ),
        // GoRoute(
        //   path: AppRoute.createAssignments.path,
        //   builder: (context, state) => const CreateAssignmentsScreen(),
        // ),

        // Common AppRoute
        GoRoute(
          path: AppRoute.profile.path,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: AppRoute.notifications.path,
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: AppRoute.setting.path,
          builder: (context, state) => const SettingsScreen(),
        ),
      ];

  static Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.error.toString()),
            ElevatedButton(
              onPressed: () => context.go(AppRoute.home.path),
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage examples:
// context.go(AppRoute.home.path);
// context.push(AppRoute.profile.path);
