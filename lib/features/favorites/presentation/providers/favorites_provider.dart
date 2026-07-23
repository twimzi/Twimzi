import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../favorites_module.dart';
import '../../domain/entities/favorite.dart';
import 'favorites_state.dart';

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, FavoritesState>(
      (ref) => FavoritesNotifier(
    getFavoritesUseCase: ref.watch(
      getFavoritesUseCaseProvider,
    ),
    getFavoritesByTypeUseCase: ref.watch(
      getFavoritesByTypeUseCaseProvider,
    ),
    addFavoriteUseCase: ref.watch(
      addFavoriteUseCaseProvider,
    ),
    removeFavoriteUseCase: ref.watch(
      removeFavoriteUseCaseProvider,
    ),
    toggleFavoriteUseCase: ref.watch(
      toggleFavoriteUseCaseProvider,
    ),
    isFavoriteUseCase: ref.watch(
      isFavoriteUseCaseProvider,
    ),
  )..loadFavorites(),
);

class FavoritesNotifier
    extends StateNotifier<FavoritesState> {
  FavoritesNotifier({
    required this.getFavoritesUseCase,
    required this.getFavoritesByTypeUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.toggleFavoriteUseCase,
    required this.isFavoriteUseCase,
  }) : super(FavoritesState.initial());

  final dynamic getFavoritesUseCase;
  final dynamic getFavoritesByTypeUseCase;
  final dynamic addFavoriteUseCase;
  final dynamic removeFavoriteUseCase;
  final dynamic toggleFavoriteUseCase;
  final dynamic isFavoriteUseCase;

  Future<void> loadFavorites() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final List<Favorite> favorites =
      await getFavoritesUseCase();

      state = state.copyWith(
        favorites: favorites,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isRefreshing: true,
      clearError: true,
    );

    try {
      final List<Favorite> favorites =
      await getFavoritesUseCase();

      state = state.copyWith(
        favorites: favorites,
        isRefreshing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadByType(
      String type,
      ) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final List<Favorite> favorites =
      await getFavoritesByTypeUseCase(
        favoriteType: type,
      );

      state = state.copyWith(
        favorites: favorites,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> toggle({
    required String entityId,
    required String entityType,
  }) async {
    await toggleFavoriteUseCase(
      entityId: entityId,
      entityType: entityType,
    );

    await refresh();
  }

  Future<bool> isFavorite({
    required String entityId,
    required String entityType,
  }) {
    return isFavoriteUseCase(
      entityId: entityId,
      entityType: entityType,
    );
  }
}