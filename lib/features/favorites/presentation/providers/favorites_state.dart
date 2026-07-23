import 'package:equatable/equatable.dart';

import '../../domain/entities/favorite.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    required this.favorites,
    required this.isLoading,
    required this.isRefreshing,
    required this.errorMessage,
  });

  final List<Favorite> favorites;
  final bool isLoading;
  final bool isRefreshing;
  final String? errorMessage;

  factory FavoritesState.initial() {
    return const FavoritesState(
      favorites: [],
      isLoading: false,
      isRefreshing: false,
      errorMessage: null,
    );
  }

  bool get isEmpty => favorites.isEmpty;

  bool get hasData => favorites.isNotEmpty;

  FavoritesState copyWith({
    List<Favorite>? favorites,
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    favorites,
    isLoading,
    isRefreshing,
    errorMessage,
  ];
}