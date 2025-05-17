import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sems/auth/views/admin_resgister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:sems/auth/views/role_selection_signin.dart';
import 'package:sems/shared/widget/refresh_dialog.dart';
import 'package:sems/student/model/student_model.dart';
import '../../router.dart';
import '../../shared/utils/error_handler.dart';
import '../../shared/utils/logger.dart';
import '../../shared/utils/snacbar_helper.dart';
part 'auth_events.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignOut>(_onSignOut);
  }

  /// Handles user sign-in process using Google Sign In.
  Future<void> _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<AuthState> emit) async {
    try {
      logger.i('Starting Google Sign In process');

      emit(AuthLoading());

      // Handle Google Sign In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        logger.w('Google sign in cancelled by user');
        emit(AuthError(message: 'Google sign in cancelled'));
        return;
      }
      logger.i('Google Sign In successful for user: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      logger.d('Got Google credentials');

      // Sign in to Firebase
      logger.i('Attempting Firebase authentication');
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        logger.e('Firebase authentication failed - no user returned');

        emit(AuthError(message: 'Failed to sign in'));
        return;
      }
      logger.d('User Metadata: ${user.metadata}');
      logger.d('User Provider Data: ${user.providerData}');
      logger.d('Role: ${user.role}');

      // Check if user exists in Firestore
      logger.i('Checking if user exists in Firestore: ${user.uid}');
      final userDocRef = _firestore.collection('users').doc(user.uid);
      final userData = await userDocRef.get();

      if (!userData.exists) {
        logger.i('New user detected - requiring registration');

        

        // New user - needs registration
        emit(AuthRequiresRegistration(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? '',
            phoneNumber: user.phoneNumber ?? '',
            // address: user.address ?? '',
            // academyName: user.academyName ?? '',
            // academyId: user.academyId ?? '',
            photoUrl: user.photoURL ?? '',
            role: user.role));
      } else {
        // Existing user - proceed to home
        logger.i('Existing user found - authenticating');

        emit(AuthAuthenticated(userData.data()!));
      }
    } catch (e) {
      logger.e('Error during sign in process', error: e);

      emit(AuthError(message: e.toString()));
    }
  }

  /// Handles registration completion process.
  Future<void> onRegistrationComplete(
      String uid, Map<String, dynamic> userData) async {
    try {
      logger.i('Starting registration completion for user: $uid');
      logger.d('Registration data: $userData');

      await _firestore.collection('users').doc(uid).set(userData);
      logger.i('User document created successfully');

      final updatedDoc = await _firestore.collection('users').doc(uid).get();
      logger.i('User registration completed successfully');

      emit(AuthAuthenticated(updatedDoc.data()!));
    } catch (e) {
      logger.e('Error during registration completion', error: e);
      emit(AuthError(message: e.toString()));
    }
  }



  /// Handles user sign-out process.
  void _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    try {
      logger.i('Starting sign out process');
      emit(AuthLoading());
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      logger.i('Sign out completed successfully');
      emit(AuthLoggedOut());
    } catch (e) {
      logger.e('Error during sign out', error: e);
      emit(AuthError(message: e.toString()));
    }
  }

  /// Handles authentication status check.
  void _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    try {
      logger.i('Checking authentication status');
      final user = _auth.currentUser;

      if (user != null) {
        logger.d('Current user found: ${user.uid}');
        final userData =
            await _firestore.collection('users').doc(user.uid).get();

        if (userData.exists) {
          logger.i('User authenticated with existing data');
          emit(AuthAuthenticated(userData.data()!));
        } else {
          logger.w('User exists in Auth but not in Firestore');
        }
      } else {
        logger.i('No authenticated user found');
        emit(AuthInitial());
      }
    } catch (e) {
      logger.e('Error checking auth status', error: e);
      emit(AuthError(message: e.toString()));
    }
  }
}

extension on User {
  get role {
    return UserRole.admin.name;
  }
}
