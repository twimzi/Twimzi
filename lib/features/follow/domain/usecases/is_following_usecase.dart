import '../repositories/follow_repository.dart';

class IsFollowingUseCase {
  const IsFollowingUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<bool> call({
    required String businessId,
  }) {
    return _repository.isFollowing(
      businessId: businessId,
    );
  }
}