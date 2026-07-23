import '../entities/follow.dart';

abstract class FollowRepository {
  /// Follow a business.
  Future<void> followBusiness({
    required String businessId,
  });

  /// Unfollow a business.
  Future<void> unfollowBusiness({
    required String businessId,
  });

  /// Returns true if the current user follows the business.
  Future<bool> isFollowing({
    required String businessId,
  });

  /// Returns the total followers of a business.
  Future<int> getFollowersCount({
    required String businessId,
  });

  /// Returns all businesses followed by the current user.
  Future<List<Follow>> getFollowingBusinesses();

  /// Returns all followers of a business.
  Future<List<Follow>> getBusinessFollowers({
    required String businessId,
  });

  /// Toggles follow status.
  Future<void> toggleFollow({
    required String businessId,
  });
}