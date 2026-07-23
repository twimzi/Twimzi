import '../../domain/entities/favorite.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl({
    required this._remoteDataSource,
  });

  final FavoritesRemoteDataSource _remoteDataSource;

  @override
  Future<List<Favorite>> getFavorites() {
    return _remoteDataSource.getFavorites();
  }

  @override
  Future<List<Favorite>> getFavoritesByType({
    required FavoriteType type,
  }) {
    return _remoteDataSource.getFavoritesByType(
      type: type,
    );
  }

  @override
  Future<bool> isFavorite({
    required String entityId,
    required FavoriteType type,
  }) {
    return _remoteDataSource.isFavorite(
      entityId: entityId,
      type: type,
    );
  }

  @override
  Future<void> addFavorite({
    required String entityId,
    required FavoriteType type,
  }) {
    return _remoteDataSource.addFavorite(
      entityId: entityId,
      type: type,
    );
  }

  @override
  Future<void> removeFavorite({
    required String entityId,
    required FavoriteType type,
  }) {
    return _remoteDataSource.removeFavorite(
      entityId: entityId,
      type: type,
    );
  }

  @override
  Future<void> toggleFavorite({
    required String entityId,
    required FavoriteType type,
  }) {
    return _remoteDataSource.toggleFavorite(
      entityId: entityId,
      type: type,
    );
  }

  @override
  Future<void> clearFavorites() {
    return _remoteDataSource.clearFavorites();
  }
}