import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box _authBox = Hive.box('authBox');

  // void initialize() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result != ConnectivityResult.none) {
  //       _syncData();
  //     }
  //   });
  // }

  Future<void> _syncData() async {
    final String? userId = _authBox.get('userId');
    if (userId != null) {
      // Sync user data
      final userData = _authBox.get('userData');
      if (userData != null) {
        await _firestore.collection('users').doc(userId).update(userData);
      }

      // Sync other data (e.g., assignments, grades)

      // TODO: Implement sync logic here
    }
  }
}
