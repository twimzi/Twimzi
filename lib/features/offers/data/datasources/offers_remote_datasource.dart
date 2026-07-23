import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/offer_model.dart';

abstract class OffersRemoteDataSource {
  Future<List<OfferModel>> getOffers();

  Future<OfferModel> getOfferById({
    required String offerId,
  });

  Future<List<OfferModel>> getBusinessOffers({
    required String businessId,
  });

  Future<List<OfferModel>> getActiveOffers();

  Future<List<OfferModel>> getFeaturedOffers();

  Future<bool> isOfferActive({
    required String offerId,
  });

  Future<bool> isOfferExpired({
    required String offerId,
  });
}

class OffersRemoteDataSourceImpl
    implements OffersRemoteDataSource {
  OffersRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  static const _table = 'offers';

  @override
  Future<List<OfferModel>> getOffers() async {
    final response = await _supabase
        .from(_table)
        .select()
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(OfferModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<OfferModel> getOfferById({
    required String offerId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('id', offerId)
        .single();

    return OfferModel.fromJson(response);
  }

  @override
  Future<List<OfferModel>> getBusinessOffers({
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
        .map(OfferModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<List<OfferModel>> getActiveOffers() async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('is_active', true)
        .gte(
      'end_date',
      DateTime.now().toIso8601String(),
    )
        .order(
      'end_date',
      ascending: true,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(OfferModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<List<OfferModel>> getFeaturedOffers() async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('is_featured', true)
        .eq('is_active', true)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(OfferModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> isOfferActive({
    required String offerId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select('is_active,end_date')
        .eq('id', offerId)
        .single();

    final isActive =
        response['is_active'] as bool? ?? false;

    final endDate = DateTime.tryParse(
      response['end_date']?.toString() ?? '',
    );

    if (endDate == null) {
      return false;
    }

    return isActive && endDate.isAfter(DateTime.now());
  }

  @override
  Future<bool> isOfferExpired({
    required String offerId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select('end_date')
        .eq('id', offerId)
        .single();

    final endDate = DateTime.tryParse(
      response['end_date']?.toString() ?? '',
    );

    if (endDate == null) {
      return true;
    }

    return endDate.isBefore(DateTime.now());
  }
}