import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

class IsFavoriteUseCase {
  const IsFavoriteUseCase({
    required this._repository,
  });

  final FavoritesRepository _repository;

  Future<bool> call({
    required String entityId,
    required FavoriteType type,
  }) {
    return _repository.isFavorite(
      entityId: entityId,
      type: type,
    );
  }
}