import '../../domain/entities/follow.dart';
import '../../domain/repositories/follow_repository.dart';
import '../datasources/follow_remote_datasource.dart';

class FollowRepositoryImpl implements FollowRepository {
  const FollowRepositoryImpl({
    required this._remoteDataSource,
  });

  final FollowRemoteDataSource _remoteDataSource;

  @override
  Future<void> followBusiness({
    required String businessId,
  }) {
    return _remoteDataSource.followBusiness(
      businessId: businessId,
    );
  }

  @override
  Future<void> unfollowBusiness({
    required String businessId,
  }) {
    return _remoteDataSource.unfollowBusiness(
      businessId: businessId,
    );
  }

  @override
  Future<void> toggleFollow({
    required String businessId,
  }) {
    return _remoteDataSource.toggleFollow(
      businessId: businessId,
    );
  }

  @override
  Future<bool> isFollowing({
    required String businessId,
  }) {
    return _remoteDataSource.isFollowing(
      businessId: businessId,
    );
  }

  @override
  Future<int> getFollowersCount({
    required String businessId,
  }) {
    return _remoteDataSource.getFollowersCount(
      businessId: businessId,
    );
  }

  @override
  Future<List<Follow>> getFollowingBusinesses() {
    return _remoteDataSource.getFollowingBusinesses();
  }

  @override
  Future<List<Follow>> getBusinessFollowers({
    required String businessId,
  }) {
    return _remoteDataSource.getBusinessFollowers(
      businessId: businessId,
    );
  }
}