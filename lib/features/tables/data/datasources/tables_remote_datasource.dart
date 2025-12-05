import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/table_model.dart';

class TablesRemoteDataSource {
  final FirebaseFirestore firestore;
  TablesRemoteDataSource({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _tablesCol => firestore.collection('tables');

  Future<List<TableModel>> fetchTables() async {
    final snapshot = await _tablesCol.get();
    final docs = snapshot.docs;
    final tables = docs.map((d) => TableModel.fromDoc(d)).toList();
    tables.sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
    return tables;
  }

  Future<void> reserveTablePending({
    required String tableId,
    required String userId,
  }) async {
    final ref = _tablesCol.doc(tableId);
    await ref.update({
      "status": "pending",
      "reservedBy": userId,
      "approved": false,
    });
  }

  Future<void> updateTableStatus({
    required String tableId,
    required String status, // "available" | "occupied" | "pending"
  }) async {
    final ref = _tablesCol.doc(tableId);
    final updateData = <String, dynamic>{
      "status": status,
    };
    if (status == "available") {
      // clear reservation info
      updateData["reservedBy"] = null;
      updateData["approved"] = false;
    }
    await ref.update(updateData);
  }

  Future<String> addTable({
    required String floor,
    required int seats,
    required int tableNumber,
    String? image,
  }) async {
    final data = {
      "floor": floor,
      "seats": seats,
      "tableNumber": tableNumber,
      "status": "available",
      "image": image ?? "",
      "reservedBy": null,
      "approved": false,
    };
    final docRef = await _tablesCol.add(data);
    return docRef.id;
  }

  Future<void> deleteTable(String tableId) async {
    await _tablesCol.doc(tableId).delete();
  }
}
