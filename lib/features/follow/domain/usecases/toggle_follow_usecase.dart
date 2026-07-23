import '../repositories/follow_repository.dart';

class ToggleFollowUseCase {
  const ToggleFollowUseCase({
    required this._repository,
  });

  final FollowRepository _repository;

  Future<void> call({
    required String businessId,
  }) {
    return _repository.toggleFollow(
      businessId: businessId,
    );
  }
}