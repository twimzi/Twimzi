import '../repositories/follow_repository.dart';

class UnfollowBusinessUseCase {
  const UnfollowBusinessUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<void> call({
    required String businessId,
  }) {
    return _repository.unfollowBusiness(
      businessId: businessId,
    );
  }
}