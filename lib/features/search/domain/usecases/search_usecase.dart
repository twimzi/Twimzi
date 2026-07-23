import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

/// Search use case.
///
/// Executes a global search across all supported entities
/// using the PostgreSQL search_all() RPC.
class SearchUseCase {
  const SearchUseCase(this._repository);

  final SearchRepository _repository;

  /// Search across all supported entities.
  Future<List<SearchResult>> call({
    required String query,
    String? entityType,
    int limit = 20,
    int offset = 0,
  }) {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      return Future.value(const <SearchResult>[]);
    }

    return _repository.search(
      query: trimmedQuery,
      entityType: entityType,
      limit: limit,
      offset: offset,
    );
  }
}