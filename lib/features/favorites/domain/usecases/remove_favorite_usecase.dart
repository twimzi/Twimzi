import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

class RemoveFavoriteUseCase {
  const RemoveFavoriteUseCase({
    required this._repository,
  });

  final FavoritesRepository _repository;

  Future<void> call({
    required String entityId,
    required FavoriteType type,
  }) {
    return _repository.removeFavorite(
      entityId: entityId,
      type: type,
    );
  }
}