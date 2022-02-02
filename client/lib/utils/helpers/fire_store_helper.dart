import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FireStoreHelper {
  Stream? onInsertChangeWatcher() {
    try {
      return FirebaseFirestore.instance
          .collection('twaslna_action')
          .doc('new_action')
          .collection('action_history')
          .snapshots();
    } catch (e) {
      return null;
    }
  }

  Future<void> insertWatcher() async {
    try {
      await FirebaseFirestore.instance
          .collection('twaslna_action')
          .doc('new_action')
          .collection('action_history')
          .add({'date': DateTime.now().toUtc().toIso8601String()}).timeout(
              const Duration(seconds: 60));
    } catch (e) {
      return ;
    }
  }
}
