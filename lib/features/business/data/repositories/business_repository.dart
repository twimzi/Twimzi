import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/create_business_request.dart';
import '../models/business_model.dart';

class BusinessRepository {
  BusinessRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  // ---------------------------------------------------------------------------
  // READ
  // ---------------------------------------------------------------------------

  Future<List<BusinessModel>> getBusinesses() async {
    final response = await _client
        .from('businesses')
        .select()
        .order('business_name');

    return (response as List)
        .map(
          (e) => BusinessModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<List<BusinessModel>> getMyBusinesses() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      return [];
    }

    final response = await _client
        .from('businesses')
        .select()
        .eq(
      'owner_profile_id',
      user.id,
    )
        .order('business_name');

    return (response as List)
        .map(
          (e) => BusinessModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<BusinessModel> getBusiness(
      String id,
      ) async {
    final response = await _client
        .from('businesses')
        .select()
        .eq(
      'id',
      id,
    )
        .single();

    return BusinessModel.fromJson(response);
  }

  Future<BusinessModel?> getBusinessByHandle(
      String handle,
      ) async {
    final response = await _client
        .from('businesses')
        .select()
        .eq(
      'handle',
      handle,
    )
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return BusinessModel.fromJson(response);
  }

  Future<bool> handleExists(
      String handle,
      ) async {
    final response = await _client
        .from('businesses')
        .select('id')
        .eq(
      'handle',
      handle,
    )
        .maybeSingle();

    return response != null;
  }

  Future<List<BusinessModel>> searchBusinesses(
      String keyword,
      ) async {
    if (keyword.trim().isEmpty) {
      return getBusinesses();
    }

    final response = await _client
        .from('businesses')
        .select()
        .or(
      'business_name.ilike.%$keyword%,'
          'legal_name.ilike.%$keyword%,'
          'handle.ilike.%$keyword%',
    )
        .order('business_name');

    return (response as List)
        .map(
          (e) => BusinessModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<String> createBusiness(
      CreateBusinessRequest request,
      ) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception(
        'User not authenticated.',
      );
    }

    final businessCode =
        'BUS-${DateTime.now().millisecondsSinceEpoch}';

    final slug = request.businessName
        .trim()
        .toLowerCase()
        .replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '-',
    );

    final handle = slug;

    final response = await _client
        .from('businesses')
        .insert({
      'owner_profile_id': user.id,
      'business_code': businessCode,
      'business_name': request.businessName,
      'legal_name': request.businessName,
      'slug': slug,
      'handle': handle,
      'share_url':
      'https://twimzi.com/@$handle',
      'description': request.description,
      'business_type': request.businessType,
      'email': request.email,
      'phone': request.phone,
      'whatsapp_number': request.whatsapp,
      'website': request.website,
    })
        .select('id')
        .single();

    return response['id'] as String;
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<void> updateBusiness(
      BusinessModel business,
      ) async {
    await _client
        .from('businesses')
        .update(
      business.toJson(),
    )
        .eq(
      'id',
      business.id,
    );
  }

  Future<void> updateHandle({
    required String businessId,
    required String handle,
  }) async {
    await _client
        .from('businesses')
        .update({
      'handle': handle,
      'share_url':
      'https://twimzi.com/@$handle',
    })
        .eq(
      'id',
      businessId,
    );
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<void> deleteBusiness(
      String id,
      ) async {
    await _client
        .from('businesses')
        .delete()
        .eq(
      'id',
      id,
    );
  }

  // ---------------------------------------------------------------------------
  // UTILITIES
  // ---------------------------------------------------------------------------

  Future<bool> businessExists(
      String id,
      ) async {
    final response = await _client
        .from('businesses')
        .select('id')
        .eq(
      'id',
      id,
    )
        .maybeSingle();

    return response != null;
  }

  Future<int> totalBusinesses() async {
    final response = await _client
        .from('businesses')
        .select('id');

    return (response as List).length;
  }

  // ---------------------------------------------------------------------------
  // STREAMS
  // ---------------------------------------------------------------------------

  Stream<List<BusinessModel>> watchBusinesses() {
    return _client
        .from('businesses')
        .stream(
      primaryKey: ['id'],
    )
        .order('business_name')
        .map(
          (rows) => rows
          .map(
            (e) => BusinessModel.fromJson(e),
      )
          .toList(),
    );
  }

  Stream<List<BusinessModel>> watchMyBusinesses() {
    final user = _client.auth.currentUser;

    if (user == null) {
      return Stream.value(
        const [],
      );
    }

    return _client
        .from('businesses')
        .stream(
      primaryKey: ['id'],
    )
        .eq(
      'owner_profile_id',
      user.id,
    )
        .order('business_name')
        .map(
          (rows) => rows
          .map(
            (e) => BusinessModel.fromJson(e),
      )
          .toList(),
    );
  }
}