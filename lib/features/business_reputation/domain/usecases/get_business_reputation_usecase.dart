import '../entities/business_reputation.dart';
import '../repositories/business_reputation_repository.dart';

class GetBusinessReputationUseCase {
  const GetBusinessReputationUseCase({
    required this._repository,
  });

  final BusinessReputationRepository _repository;

  Future<BusinessReputation> call({
    required String businessId,
  }) {
    return _repository.getBusinessReputation(
      businessId: businessId,
    );
  }
}