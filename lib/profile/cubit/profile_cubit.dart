import 'package:flutter/material.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../model/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDataCubit extends Cubit<UserData?> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthBloc _authBloc;

  FirestoreDataCubit(this._authBloc) : super(null) {
    debugPrint('FirestoreDataCubit created');
    // Listen to AuthBloc state changes
    _authBloc.stream.listen((authState) {
      debugPrint('AuthBloc state changed: $authState');
      if (authState is AuthAuthenticated) {
        debugPrint('Fetching user data for authenticated user');
        fetchUserData();
      } else {
        debugPrint('Not authenticated, clearing user data');
        emit(null); // Clear user data if not authenticated
      }
    });
  }

  void fetchUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      debugPrint('Not authenticated, clearing user data');
      emit(null);
      return;
    }
    final String uid = user.uid;
    debugPrint('fetchUserData called with userId: $uid');
    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        debugPrint('User data fetched successfully');
        final userData = UserData.fromMap(userDoc.data()!);
        emit(userData);
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      emit(null);
    }
  }


  // Method to update user data
  Future<void> updateUserData(UserData userData, dynamic authState) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': userData.name,
          // Email is fixed as from google Login
          'academyName': userData.academyName,
          'phoneNumber': userData.phoneNumber,
          'address': userData.address,
        });
        // Fetch updated data
        fetchUserData();
      }
    } catch (e) {
      debugPrint('Error updating user data: $e');
    }
  }

 

  UserData? getUserData() {
    return state;
  }
}

