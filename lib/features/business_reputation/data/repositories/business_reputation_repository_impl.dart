import '../../domain/entities/business_reputation.dart';
import '../../domain/repositories/business_reputation_repository.dart';
import '../datasources/business_reputation_remote_datasource.dart';

class BusinessReputationRepositoryImpl
    implements BusinessReputationRepository {
  const BusinessReputationRepositoryImpl({
    required this._remoteDataSource,
  });

  final BusinessReputationRemoteDataSource _remoteDataSource;

  @override
  Future<BusinessReputation> getBusinessReputation({
    required String businessId,
  }) {
    return _remoteDataSource.getBusinessReputation(
      businessId: businessId,
    );
  }

  @override
  Future<BusinessReputation> refreshBusinessReputation({
    required String businessId,
  }) async {
    await _remoteDataSource.refreshBusinessReputation(
      businessId: businessId,
    );

    return _remoteDataSource.getBusinessReputation(
      businessId: businessId,
    );
  }

  @override
  Future<void> updateBusinessReputation({
    required BusinessReputation reputation,
  }) {
    throw UnimplementedError(
      'Business reputation is calculated and updated by PostgreSQL.',
    );
  }

  @override
  Future<bool> isBusinessVerified({
    required String businessId,
  }) {
    return _remoteDataSource.isBusinessVerified(
      businessId: businessId,
    );
  }

  @override
  Future<int> getProfileCompletion({
    required String businessId,
  }) {
    return _remoteDataSource.getProfileCompletion(
      businessId: businessId,
    );
  }

  @override
  Future<List<String>> getBusinessBadges({
    required String businessId,
  }) {
    return _remoteDataSource.getBusinessBadges(
      businessId: businessId,
    );
  }

  @override
  Future<BusinessReputation> calculateBusinessReputation({
    required String businessId,
  }) async {
    return refreshBusinessReputation(
      businessId: businessId,
    );
  }
}