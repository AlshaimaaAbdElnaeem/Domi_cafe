part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Order> orders;
  HomeLoaded(this.orders);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
