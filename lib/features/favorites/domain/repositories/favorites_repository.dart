import '../entities/favorite.dart';

abstract class FavoritesRepository {
  /// Returns all favorites for the currently authenticated user.
  Future<List<Favorite>> getFavorites();

  /// Returns favorites filtered by entity type.
  Future<List<Favorite>> getFavoritesByType({
    required FavoriteType type,
  });

  /// Checks whether an entity is already saved.
  Future<bool> isFavorite({
    required String entityId,
    required FavoriteType type,
  });

  /// Saves an entity as favorite.
  Future<void> addFavorite({
    required String entityId,
    required FavoriteType type,
  });

  /// Removes an entity from favorites.
  Future<void> removeFavorite({
    required String entityId,
    required FavoriteType type,
  });

  /// Adds if missing, removes if already saved.
  Future<void> toggleFavorite({
    required String entityId,
    required FavoriteType type,
  });

  /// Removes all favorites of the current user.
  Future<void> clearFavorites();
}