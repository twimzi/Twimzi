import '../entities/business_reputation.dart';

abstract class BusinessReputationRepository {
  /// Returns the reputation of a business.
  Future<BusinessReputation> getBusinessReputation({
    required String businessId,
  });

  /// Calculates the latest reputation based on business data.
  Future<BusinessReputation> calculateBusinessReputation({
    required String businessId,
  });

  /// Refreshes and persists the calculated reputation.
  Future<BusinessReputation> refreshBusinessReputation({
    required String businessId,
  });

  /// Updates an existing reputation record.
  Future<void> updateBusinessReputation({
    required BusinessReputation reputation,
  });

  /// Returns whether the business is verified.
  Future<bool> isBusinessVerified({
    required String businessId,
  });

  /// Returns the overall profile completion percentage.
  Future<int> getProfileCompletion({
    required String businessId,
  });

  /// Returns all earned badges.
  Future<List<String>> getBusinessBadges({
    required String businessId,
  });
}