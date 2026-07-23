import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl({
    required this._remoteDataSource,
  });

  final SearchRemoteDataSource _remoteDataSource;

  @override
  Future<List<SearchResult>> search({
    required String query,
    String? entityType,
    int limit = 20,
    int offset = 0,
  }) async {
    final results = await _remoteDataSource.search(
      query: query,
      entityType: entityType,
      limit: limit,
      offset: offset,
    );

    return List<SearchResult>.unmodifiable(results);
  }
}