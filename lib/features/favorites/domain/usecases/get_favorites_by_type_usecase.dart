import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesByTypeUseCase {
  const GetFavoritesByTypeUseCase({
    required this._repository,
  });

  final FavoritesRepository _repository;

  Future<List<Favorite>> call({
    required FavoriteType type,
  }) {
    return _repository.getFavoritesByType(
      type: type,
    );
  }
}