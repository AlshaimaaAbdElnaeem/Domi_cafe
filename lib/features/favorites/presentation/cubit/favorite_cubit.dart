// lib/features/favorites/presentation/cubit/favorite_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository repository;

  FavoriteCubit(this.repository) : super(FavoriteInitial()) {
    loadFavorites();
  }

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  void loadFavorites() {
    final uid = userId;
    if (uid == null) {
      emit(FavoriteError("يجب تسجيل الدخول أولاً"));
      return;
    }

    emit(FavoriteLoading());

    repository.getFavorites(uid).listen(
      (data) => emit(FavoriteLoaded(data)),
      onError: (e) => emit(FavoriteError(e.toString())),
    );
  }

  Future<void> toggleFavorite(FavoriteEntity product) async {
    final uid = userId;
    if (uid == null) {
      emit(FavoriteError("يجب تسجيل الدخول أولاً"));
      return;
    }

    if (state is FavoriteLoaded) {
      final current = (state as FavoriteLoaded).favorites;
      final exists = current.any((fav) => fav.productId == product.productId);

      if (exists) {
        await repository.removeFavorite(uid, product.productId);
      } else {
        await repository.addFavorite(uid, product);
      }
    }
  }
}
