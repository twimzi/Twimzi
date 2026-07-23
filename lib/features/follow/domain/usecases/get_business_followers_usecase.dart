import '../entities/follow.dart';
import '../repositories/follow_repository.dart';

class GetBusinessFollowersUseCase {
  const GetBusinessFollowersUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<List<Follow>> call({
    required String businessId,
  }) {
    return _repository.getBusinessFollowers(
      businessId: businessId,
    );
  }
}