import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

class SearchAllUseCase {
  const SearchAllUseCase({
    required this._repository,
  });

  final SearchRepository _repository;

  Future<List<SearchResult>> call({
    required String query,
  }) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      return const [];
    }

    return _repository.search(
      query: trimmedQuery,
    );
  }
}