import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  const GetFavoritesUseCase({
    required this._repository,
  });

  final FavoritesRepository _repository;

  Future<List<Favorite>> call() {
    return _repository.getFavorites();
  }
}