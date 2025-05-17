part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> userData;

  AuthAuthenticated(
    this.userData,
  );
}

class AuthRequiresRegistration extends AuthState {
  final String uid;
  final String email;
  final String name;

  final String? academyName;
  final String? academyId;
  final String? phoneNumber;
  final String? address;
  late final dynamic photoUrl;



  final String role;

  AuthRequiresRegistration(
      {required this.uid,
      required this.email,
      required this.name,
    this.academyName,
    this.academyId,
    this.phoneNumber,
    this.address,
    this.photoUrl,
    required this.role,
  });
}

class AuthSuccess extends AuthState {
  final Student user;

  AuthSuccess({required this.user});
}

class AuthLoggedOut extends AuthState {}


class AuthRegisterUser extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class AuthUnauthenticated extends AuthState {
  final String message;
  AuthUnauthenticated(this.message);
}
