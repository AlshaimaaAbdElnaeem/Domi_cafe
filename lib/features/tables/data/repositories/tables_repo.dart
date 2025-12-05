import '../datasources/tables_remote_datasource.dart';
import '../models/table_model.dart';

class TablesRepo {
  final TablesRemoteDataSource remote;

  TablesRepo({required this.remote});

  Future<List<TableModel>> getAllTables() => remote.fetchTables();

  Future<void> reserveTable({required String tableId, required String userId}) =>
      remote.reserveTablePending(tableId: tableId, userId: userId);

  Future<void> changeStatus({required String tableId, required String status}) =>
      remote.updateTableStatus(tableId: tableId, status: status);

  Future<String> addTable({
    required String floor,
    required int seats,
    required int tableNumber,
    String? image,
  }) =>
      remote.addTable(floor: floor, seats: seats, tableNumber: tableNumber, image: image);

  Future<void> deleteTable(String id) => remote.deleteTable(id);
}
