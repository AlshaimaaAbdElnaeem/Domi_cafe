import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
part 'home_state.dart';

class Order {
  final String id;
  final String status;
  final DateTime createdAt;

  Order({required this.id, required this.status, required this.createdAt});
}

class HomeCubit extends Cubit<HomeState> {
  final FirebaseFirestore firestore;

  HomeCubit(this.firestore) : super(HomeInitial());

  void fetchUserOrders(String userId) {
    emit(HomeLoading());

    try {
      firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        final orders = snapshot.docs.map((doc) {
          final data = doc.data();
          return Order(
            id: doc.id,
            status: data['status'] ?? 'Pending',
            createdAt: (data['createdAt'] as Timestamp).toDate(),
          );
        }).toList();
        emit(HomeLoaded(orders));
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  List<Order> filterOrders(List<Order> orders, String filter) {
    if (filter == 'All') return orders;
    return orders.where((order) => order.status == filter).toList();
  }
}
