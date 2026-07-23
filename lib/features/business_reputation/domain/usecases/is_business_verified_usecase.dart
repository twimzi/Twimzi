import '../repositories/business_reputation_repository.dart';

class IsBusinessVerifiedUseCase {
  const IsBusinessVerifiedUseCase({
    required this._repository,
  });

  final BusinessReputationRepository _repository;

  Future<bool> call({
    required String businessId,
  }) {
    return _repository.isBusinessVerified(
      businessId: businessId,
    );
  }
}