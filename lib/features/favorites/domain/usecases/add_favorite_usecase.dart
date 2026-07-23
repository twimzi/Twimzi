import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

class AddFavoriteUseCase {
  const AddFavoriteUseCase({
    required this._repository,
  });

  final FavoritesRepository _repository;

  Future<void> call({
    required String entityId,
    required FavoriteType type,
  }) {
    return _repository.addFavorite(
      entityId: entityId,
      type: type,
    );
  }
}