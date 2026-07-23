import '../repositories/follow_repository.dart';

class FollowBusinessUseCase {
  const FollowBusinessUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<void> call({
    required String businessId,
  }) {
    return _repository.followBusiness(
      businessId: businessId,
    );
  }
}