import '../repositories/business_reputation_repository.dart';

class GetBusinessBadgesUseCase {
  const GetBusinessBadgesUseCase({
    required this._repository,
  });

  final BusinessReputationRepository _repository;

  Future<List<String>> call({
    required String businessId,
  }) {
    return _repository.getBusinessBadges(
      businessId: businessId,
    );
  }
}