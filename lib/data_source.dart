import 'package:cloud_firestore/cloud_firestore.dart';

class DataSource {
  Future<void> insertDataFirebase(Map<String, dynamic> dateAndTime) async {
    CollectionReference loadData =
        FirebaseFirestore.instance.collection('date_time');
    try {
      await loadData.doc(dateAndTime.keys.first).set(dateAndTime);
    } catch (e) {
      print('Error inserting data to Firestore: $e');
      throw e; // rethrow the exception after logging it
    }
  }
}
