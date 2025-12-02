import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// -------------------------
  /// ADD (POST)
  /// -------------------------
  Future<void> addData({
    required String collection,
    required Map<String, dynamic> data,
    String? docId, // optional if you want to set a specific id
  }) async {
    try {
      if (docId != null) {
        await _db.collection(collection).doc(docId).set(data);
      } else {
        await _db.collection(collection).add(data);
      }
    } catch (e) {
      throw Exception("Failed to add data: $e");
    }
  }

  /// -------------------------
  /// GET ONE DOCUMENT
  /// -------------------------
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      DocumentSnapshot doc =
          await _db.collection(collection).doc(docId).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to get document: $e");
    }
  }

  /// -------------------------
  /// GET ALL DOCUMENTS
  /// -------------------------
  Future<List<Map<String, dynamic>>> getCollection({
    required String collection,
  }) async {
    try {
      QuerySnapshot snapshot =
          await _db.collection(collection).get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception("Failed to get collection: $e");
    }
  }
}
