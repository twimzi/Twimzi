import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultModel>> search({
    required String query,
    String? entityType,
    int limit = 20,
    int offset = 0,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  @override
  Future<List<SearchResultModel>> search({
    required String query,
    String? entityType,
    int limit = 20,
    int offset = 0,
  }) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      return const [];
    }

    final response = await _supabase.rpc(
      'search_all',
      params: {
        'search_query': trimmedQuery,
        'entity_type': entityType,
        'limit_count': limit,
        'offset_count': offset,
      },
    );

    final data = (response as List<dynamic>).cast<Map<String, dynamic>>();

    return data
        .map(SearchResultModel.fromJson)
        .toList(growable: false);
  }
}