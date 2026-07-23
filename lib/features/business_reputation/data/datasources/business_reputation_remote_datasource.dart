import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/business_reputation_model.dart';

abstract class BusinessReputationRemoteDataSource {
  Future<BusinessReputationModel> getBusinessReputation({
    required String businessId,
  });

  Future<void> refreshBusinessReputation({
    required String businessId,
  });

  Future<bool> isBusinessVerified({
    required String businessId,
  });

  Future<int> getProfileCompletion({
    required String businessId,
  });

  Future<List<String>> getBusinessBadges({
    required String businessId,
  });
}

class BusinessReputationRemoteDataSourceImpl
    implements BusinessReputationRemoteDataSource {
  BusinessReputationRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  @override
  Future<BusinessReputationModel> getBusinessReputation({
    required String businessId,
  }) async {
    final response = await _supabase
        .from('business_reputation')
        .select()
        .eq('business_id', businessId)
        .single();

    return BusinessReputationModel.fromJson(response);
  }

  @override
  Future<void> refreshBusinessReputation({
    required String businessId,
  }) async {
    await _supabase.rpc(
      'refresh_business_reputation',
      params: {
        'p_business_id': businessId,
      },
    );
  }

  @override
  Future<bool> isBusinessVerified({
    required String businessId,
  }) async {
    final response = await _supabase
        .from('businesses')
        .select('is_verified')
        .eq('id', businessId)
        .single();

    return response['is_verified'] as bool? ?? false;
  }

  @override
  Future<int> getProfileCompletion({
    required String businessId,
  }) async {
    final response = await _supabase
        .from('businesses')
        .select('profile_completion')
        .eq('id', businessId)
        .single();

    return (response['profile_completion'] as num?)?.toInt() ?? 0;
  }

  @override
  Future<List<String>> getBusinessBadges({
    required String businessId,
  }) async {
    final response = await _supabase
        .from('business_reputation')
        .select('badges')
        .eq('business_id', businessId)
        .single();

    return (response['badges'] as List<dynamic>?)
        ?.map((badge) => badge.toString())
        .toList(growable: false) ??
        const [];
  }
}