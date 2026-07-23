import '../entities/follow.dart';
import '../repositories/follow_repository.dart';

class GetFollowingBusinessesUseCase {
  const GetFollowingBusinessesUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<List<Follow>> call() {
    return _repository.getFollowingBusinesses();
  }
}