import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/table_model.dart';
import '../../data/datasources/tables_remote_datasource.dart';
import '../../data/repositories/tables_repo.dart';
import 'tables_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TablesCubit extends Cubit<TablesState> {
  final TablesRepo repo;
  TablesCubit({required this.repo}) : super(TablesInitial());

  // keep a cached list for quick UI updates
  List<TableModel> _cached = [];

  Future<void> fetchTables() async {
    emit(TablesLoading());
    try {
      final tables = await repo.getAllTables();
      _cached = tables;
      emit(TablesLoaded(tables));
    } catch (e) {
      emit(TablesError(e.toString()));
    }
  }

  Future<void> reserveTable(String tableId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(TablesError("User not authenticated"));
        return;
      }
      await repo.reserveTable(tableId: tableId, userId: user.uid);

      // optimistically update local cache
      _cached = _cached.map((t) {
        if (t.id == tableId) {
          return TableModel(
            id: t.id,
            tableNumber: t.tableNumber,
            floor: t.floor,
            status: "pending",
            reservedBy: user.uid,
            approved: false,
            image: t.image,
            seats: t.seats,
            userName: null,
          );
        }
        return t;
      }).toList();

      emit(ReservationSuccess(tableId));
      emit(TablesLoaded(List.from(_cached)));
    } catch (e) {
      emit(TablesError(e.toString()));
    }
  }

  Future<void> changeStatus(String tableId, String status) async {
    try {
      await repo.changeStatus(tableId: tableId, status: status);

      _cached = _cached.map((t) {
        if (t.id == tableId) {
          return TableModel(
            id: t.id,
            tableNumber: t.tableNumber,
            floor: t.floor,
            status: status,
            reservedBy: status == "available" ? null : t.reservedBy,
            approved: status == "available" ? false : t.approved,
            image: t.image,
            seats: t.seats,
            userName: status == "available" ? null : t.userName,
          );
        }
        return t;
      }).toList();

      emit(OperationSuccess("Status updated"));
      emit(TablesLoaded(List.from(_cached)));
    } catch (e) {
      emit(TablesError(e.toString()));
    }
  }

  Future<void> addTable({required String floor, required int seats, required int tableNumber}) async {
    try {
      final id = await repo.addTable(floor: floor, seats: seats, tableNumber: tableNumber);
      await fetchTables(); // refresh
      emit(OperationSuccess("Table added ($id)"));
    } catch (e) {
      emit(TablesError(e.toString()));
    }
  }

  Future<void> deleteTable(String id) async {
    try {
      await repo.deleteTable(id);
      _cached.removeWhere((t) => t.id == id);
      emit(OperationSuccess("Table deleted"));
      emit(TablesLoaded(List.from(_cached)));
    } catch (e) {
      emit(TablesError(e.toString()));
    }
  }
}
