import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler {
  static String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      // Add more cases as needed
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
