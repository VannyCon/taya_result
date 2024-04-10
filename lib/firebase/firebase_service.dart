import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Stream<QuerySnapshot> getNotesStream() {
    return FirebaseFirestore.instance
        .collection('taya_result')
        .doc('2024')
        .collection('result')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static Future<DocumentSnapshot> appStatus() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('app_status')
          .doc('status')
          .get();
      return snapshot;
    } catch (e) {
      // Handle errors, e.g., network issues, permission denied, etc.
      throw Exception('Failed to fetch app status: $e');
    }
  }
}
