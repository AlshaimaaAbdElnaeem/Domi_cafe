import 'package:flutter/material.dart';
import '../../data/models/table_model.dart';

class TableCard extends StatelessWidget {
  final TableModel table;
  final bool isSelected;
  const TableCard({super.key, required this.table, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = table.status;
    Color statusColor = Colors.green;
    if (status == "occupied") statusColor = Colors.red;
    if (status == "pending") statusColor = Colors.orange;

    final cardBg = theme.cardColor;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (status == "available")
            BoxShadow(color: Colors.green.withOpacity(0.15), blurRadius: 8, spreadRadius: 1),
          if (status == "occupied")
            BoxShadow(color: Colors.red.withOpacity(0.15), blurRadius: 8, spreadRadius: 1),
          if (status == "pending")
            BoxShadow(color: Colors.orange.withOpacity(0.15), blurRadius: 8, spreadRadius: 1),
        ],
        border: Border.all(color: isSelected ? theme.primaryColor : Colors.transparent, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: table.image != null && table.image!.isNotEmpty
                ? NetworkImage(table.image!)
                : const NetworkImage('https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=900&q=80'),
          ),
          const SizedBox(height: 8),
          Text(
            'Table ${table.tableNumber}',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            status == "available" ? "Available" : (status == "pending" ? "Pending" : "Occupied"),
            style: theme.textTheme.bodyMedium?.copyWith(color: statusColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Seats: ${table.seats}', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
