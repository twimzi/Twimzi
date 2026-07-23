import '../entities/search_result.dart';

abstract class SearchRepository {
  /// Performs a global search across all searchable entities.
  ///
  /// Returns businesses, products and services ordered by
  /// PostgreSQL search relevance.
  Future<List<SearchResult>> search({
    required String query,
    String? entityType,
    int limit = 20,
    int offset = 0,
  });
}