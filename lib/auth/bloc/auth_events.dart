part of 'auth_bloc.dart';

abstract class AuthEvent {}

// For Google Auth
class SignInWithGoogle extends AuthEvent {
  final String role;
  final String? uid;
  late final dynamic photoUrl;
  final String? name;
  final String? email;
  final String? academyName;
  final String? academyId;
  final String? phoneNumber;
  final String? address;

  SignInWithGoogle({
    required this.role,
    this.uid,
    this.name,
    this.photoUrl,
    this.email,
    this.academyName,
    this.academyId,
    this.phoneNumber,
    this.address,
  });
}

class StudentLogin extends AuthEvent {
  final String academyId;
  final String studentId;
  final String dob;

  StudentLogin(
    this.academyId,
    this.studentId,
    this.dob,
  );
}

class SignOut extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
