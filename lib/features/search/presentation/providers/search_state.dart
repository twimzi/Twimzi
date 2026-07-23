import 'package:equatable/equatable.dart';

import '../../domain/entities/search_result.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.entityType,
    this.results = const <SearchResult>[],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.limit = 20,
    this.offset = 0,
  });

  final String query;
  final String? entityType;
  final List<SearchResult> results;

  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;

  final String? errorMessage;

  final int limit;
  final int offset;

  bool get hasResults => results.isNotEmpty;

  bool get isEmpty =>
      !isLoading &&
          results.isEmpty &&
          query.trim().isNotEmpty;

  SearchState copyWith({
    String? query,
    String? entityType,
    List<SearchResult>? results,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorMessage,
    bool clearError = false,
    int? limit,
    int? offset,
  }) {
    return SearchState(
      query: query ?? this.query,
      entityType: entityType ?? this.entityType,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory SearchState.initial() => const SearchState();

  @override
  List<Object?> get props => [
    query,
    entityType,
    results,
    isLoading,
    isLoadingMore,
    hasMore,
    errorMessage,
    limit,
    offset,
  ];
}