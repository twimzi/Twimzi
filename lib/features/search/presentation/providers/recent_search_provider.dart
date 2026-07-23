import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/search_result.dart';

/// Recent searches are not implemented in Twimzi V1.
/// This provider intentionally returns an empty list.
final recentSearchProvider =
Provider<List<SearchResult>>((ref) => const []);

/// Trending searches are not implemented in Twimzi V1.
final trendingSearchProvider =
Provider<List<String>>((ref) => const []);

final recentSearchControllerProvider =
Provider<RecentSearchController>(
      (ref) => RecentSearchController(),
);

class RecentSearchController {
  const RecentSearchController();

  Future<void> refresh() async {}

  Future<void> clearAll() async {}

  Future<void> remove(String query) async {}

  Future<void> save(String query) async {}
}