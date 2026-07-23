import '../repositories/business_reputation_repository.dart';

class GetProfileCompletionUseCase {
  const GetProfileCompletionUseCase({
    required this._repository,
  });

  final BusinessReputationRepository _repository;

  Future<int> call({
    required String businessId,
  }) {
    return _repository.getProfileCompletion(
      businessId: businessId,
    );
  }
}