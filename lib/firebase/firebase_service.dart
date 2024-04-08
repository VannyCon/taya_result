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
}
