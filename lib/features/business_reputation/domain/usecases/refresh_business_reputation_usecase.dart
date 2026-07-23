import '../repositories/business_reputation_repository.dart';

class RefreshBusinessReputationUseCase {
  const RefreshBusinessReputationUseCase({
    required this._repository,
  });

  final BusinessReputationRepository _repository;

  Future<void> call({
    required String businessId,
  }) {
    return _repository.refreshBusinessReputation(
      businessId: businessId,
    );
  }
}