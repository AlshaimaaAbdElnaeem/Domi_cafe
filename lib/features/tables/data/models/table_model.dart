import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  final String id;
  final int tableNumber;
  final String floor; // "Upstairs" / "Downstairs"
  final String status; // "available" | "pending" | "occupied"
  final String? reservedBy; // uid
  final bool? approved;
  final String? image;
  final int seats;
  final String? userName;

  TableModel({
    required this.id,
    required this.tableNumber,
    required this.floor,
    required this.status,
    this.reservedBy,
    this.approved,
    this.image,
    required this.seats,
    this.userName,
  });

  factory TableModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TableModel(
      id: doc.id,
      tableNumber: (data['tableNumber'] ?? 0) as int,
      floor: (data['floor'] ?? 'Downstairs') as String,
      status: (data['status'] ?? 'available') as String,
      reservedBy: data['reservedBy'] as String?,
      approved: data['approved'] as bool? ?? false,
      image: data['image'] as String?,
      seats: (data['seats'] ?? 1) as int,
      userName: data['userName'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        "tableNumber": tableNumber,
        "floor": floor,
        "status": status,
        "reservedBy": reservedBy,
        "approved": approved,
        "image": image,
        "seats": seats,
        "userName": userName,
      };
}
