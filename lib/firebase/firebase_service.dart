import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseService {
  late final String link;
  Stream<QuerySnapshot> getNotesStream() {
    return FirebaseFirestore.instance
        .collection('taya_result')
        .doc('2024')
        .collection('result')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static Stream<DocumentSnapshot> updateLink() {
    return FirebaseFirestore.instance
        .collection('app_status')
        .doc('status')
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

  static Future<void> openLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
