import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/create_business_request.dart';
import '../models/business_model.dart';

class BusinessRepository {
  BusinessRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<List<BusinessModel>> getBusinesses() async {
    final response = await _client
        .from('businesses')
        .select()
        .order('business_name');

    return (response as List)
        .map(
          (json) => BusinessModel.fromJson(
        json as Map<String, dynamic>,
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
          (json) => BusinessModel.fromJson(
        json as Map<String, dynamic>,
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
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-');

    final response = await _client
        .from('businesses')
        .insert({
      'owner_profile_id': request.ownerProfileId,
      'business_code': businessCode,
      'business_name': request.businessName,
      'legal_name': request.businessName,
      'slug': slug,
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
}