import '../repositories/follow_repository.dart';

class GetFollowersCountUseCase {
  const GetFollowersCountUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<int> call({
    required String businessId,
  }) {
    return _repository.getFollowersCount(
      businessId: businessId,
    );
  }
}