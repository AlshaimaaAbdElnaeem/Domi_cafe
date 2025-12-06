import 'package:equatable/equatable.dart';
import '../../data/models/table_model.dart';

abstract class TablesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TablesInitial extends TablesState {}

class TablesLoading extends TablesState {}

class TablesLoaded extends TablesState {
  final List<TableModel> tables;
  TablesLoaded(this.tables);

  @override
  List<Object?> get props => [tables];
}

class TablesError extends TablesState {
  final String message;
  TablesError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReservationSuccess extends TablesState {
  final String tableId;
  ReservationSuccess(this.tableId);

  @override
  List<Object?> get props => [tableId];
}

class OperationSuccess extends TablesState {
  final String info;
  OperationSuccess(this.info);

  @override
  List<Object?> get props => [info];
}
