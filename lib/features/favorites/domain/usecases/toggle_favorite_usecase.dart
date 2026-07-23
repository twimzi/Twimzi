import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase({
    required this._repository,
  });

  final FavoritesRepository _repository;

  Future<void> call({
    required String entityId,
    required FavoriteType type,
  }) {
    return _repository.toggleFavorite(
      entityId: entityId,
      type: type,
    );
  }
}