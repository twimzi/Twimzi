import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/follow_model.dart';

abstract class FollowRemoteDataSource {
  Future<void> followBusiness({
    required String businessId,
  });

  Future<void> unfollowBusiness({
    required String businessId,
  });

  Future<void> toggleFollow({
    required String businessId,
  });

  Future<bool> isFollowing({
    required String businessId,
  });

  Future<int> getFollowersCount({
    required String businessId,
  });

  Future<List<FollowModel>> getFollowingBusinesses();

  Future<List<FollowModel>> getBusinessFollowers({
    required String businessId,
  });
}

class FollowRemoteDataSourceImpl
    implements FollowRemoteDataSource {
  FollowRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  static const String _table = 'business_followers';

  @override
  Future<void> followBusiness({
    required String businessId,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw const AuthException(
        'User is not authenticated.',
      );
    }

    await _supabase.from(_table).insert({
      'business_id': businessId,
      'follower_id': userId,
    });
  }

  @override
  Future<void> unfollowBusiness({
    required String businessId,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return;
    }

    await _supabase
        .from(_table)
        .delete()
        .eq('business_id', businessId)
        .eq('follower_id', userId);
  }

  @override
  Future<void> toggleFollow({
    required String businessId,
  }) async {
    final following = await isFollowing(
      businessId: businessId,
    );

    if (following) {
      await unfollowBusiness(
        businessId: businessId,
      );
    } else {
      await followBusiness(
        businessId: businessId,
      );
    }
  }

  @override
  Future<bool> isFollowing({
    required String businessId,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return false;
    }

    final response = await _supabase
        .from(_table)
        .select('id')
        .eq('business_id', businessId)
        .eq('follower_id', userId)
        .maybeSingle();

    return response != null;
  }

  @override
  Future<int> getFollowersCount({
    required String businessId,
  }) async {
    final count = await _supabase
        .from(_table)
        .count(CountOption.exact)
        .eq('business_id', businessId);

    return count;
  }

  @override
  Future<List<FollowModel>> getFollowingBusinesses() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return const [];
    }

    final response = await _supabase
        .from(_table)
        .select()
        .eq('follower_id', userId)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(FollowModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<List<FollowModel>> getBusinessFollowers({
    required String businessId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('business_id', businessId)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(FollowModel.fromJson)
        .toList(growable: false);
  }
}