import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/tables_remote_datasource.dart';
import '../../data/repositories/tables_repo.dart';
import '../cubit/tables_cubit.dart';
import '../cubit/tables_state.dart';
import '../widgets/table_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  late TablesCubit cubit;
  final floors = const ["Upstairs", "Downstairs"];

  @override
  void initState() {
    super.initState();
    final repo = TablesRepo(remote: TablesRemoteDataSource());
    cubit = TablesCubit(repo: repo);
    cubit.fetchTables();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  void _showReserveModal(BuildContext context, table) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Reserve Table ${table.tableNumber}'),
        content: const Text('Do you want to reserve this table?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await cubit.reserveTable(table.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reservation requested (pending admin).')),
              );
            },
            child: const Text('Reserve'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provide the cubit locally for this screen
    return BlocProvider<TablesCubit>.value(
      value: cubit,
      child: BlocBuilder<TablesCubit, TablesState>(
        builder: (context, state) {
          if (state is TablesLoading || state is TablesInitial) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is TablesError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Select Your Table')),
              body: Center(child: Text('Error: ${state.message}')),
            );
          }

          List tables = [];
          if (state is TablesLoaded) tables = state.tables;

          // counts helpers
          int countStatus(String floor, String status) =>
              tables.where((t) => t.floor == floor && t.status == status).length;

          return Scaffold(
            appBar: AppBar(title: const Text('Select Your Table')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  for (final floor in floors) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(floor, style: TextStyle(fontSize: 20, color: Colors.brown[700], fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _statusChip('Available', countStatus(floor, 'available'), Colors.green),
                        const SizedBox(width: 8),
                        _statusChip('Occupied', countStatus(floor, 'occupied'), Colors.red),
                        const SizedBox(width: 8),
                        _statusChip('Pending', countStatus(floor, 'pending'), Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: tables.where((t) => t.floor == floor).length,
                      itemBuilder: (context, idx) {
                        final floorTables = tables.where((t) => t.floor == floor).toList()
                          ..sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
                        final table = floorTables[idx];
                        return GestureDetector(
                          onTap: () {
                            // only allow reserving available from mobile
                            if (table.status == 'available') {
                              _showReserveModal(context, table);
                            } else {
                              // show info
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(table.status == 'pending' ? 'Pending approval' : 'Currently occupied')),
                              );
                            }
                          },
                          child: TableCard(table: table),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _statusChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
      child: Text('$label: $count', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
