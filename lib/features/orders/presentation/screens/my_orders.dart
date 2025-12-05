import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

// موديل الأوردر (dummy data مع التفاصيل)
class Order {
  final String id;
  final String status;
  final DateTime createdAt;
  final double totalPrice;
  final int itemsCount;

  Order({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.totalPrice,
    required this.itemsCount,
  });
}

class MyOrdersScreen extends StatefulWidget {
  final String userId;
  const MyOrdersScreen({super.key, required this.userId});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String selectedFilter = 'All';
  final filters = ['All', 'Pending', 'Completed', 'Rejected'];

  // Dummy data لعرض التصميم
  final List<Order> dummyOrders = [
    Order(id: '001', status: 'Pending', createdAt: DateTime.now().subtract(const Duration(days: 1)), totalPrice: 45.0, itemsCount: 3),
    Order(id: '002', status: 'Completed', createdAt: DateTime.now().subtract(const Duration(days: 2)), totalPrice: 78.5, itemsCount: 5),
    Order(id: '003', status: 'Rejected', createdAt: DateTime.now().subtract(const Duration(days: 3)), totalPrice: 30.0, itemsCount: 2),
    Order(id: '004', status: 'Pending', createdAt: DateTime.now(), totalPrice: 60.0, itemsCount: 4),
  ];

  List<Order> _filterOrders(List<Order> orders) {
    if (selectedFilter == 'All') return orders;
    return orders.where((o) => o.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _filterOrders(dummyOrders);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppColors.lightPrimary,
      ),
      body: Column(
        children: [
          // فلتر الأوردرات
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = filter == selectedFilter;
                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.lightPrimary : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.lightPrimary),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.lightPrimary.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : [],
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.lightText,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // قائمة الأوردرات
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];

                Color statusColor = AppColors.lightPrimary; // Pending
                if (order.status == 'Completed') statusColor = Colors.green;
                if (order.status == 'Rejected') statusColor = Colors.red;

                return Card(
                  color: AppColors.lightSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header: Order ID + Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #${order.id}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightHeading,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Order details: Date, Items, Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  '${order.createdAt.toLocal()}'.split(' ')[0],
                                  style: TextStyle(color: AppColors.lightText),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.shopping_bag, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  '${order.itemsCount} items',
                                  style: TextStyle(color: AppColors.lightText),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                                Text(
                                  order.totalPrice.toStringAsFixed(2),
                                  style: TextStyle(color: AppColors.lightText),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Divider
                        Divider(color: Colors.grey.shade300),
                        // Footer: Optional actions (مثلاً Details button)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.lightPrimary.withOpacity(0.1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: Text(
                              'View Details',
                              style: TextStyle(
                                color: AppColors.lightPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
