import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/search_remote_datasource.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/usecases/search_usecase.dart';
import 'search_state.dart';

final searchRemoteDataSourceProvider =
Provider<SearchRemoteDataSource>((ref) {
  return SearchRemoteDataSourceImpl(
    supabaseClient: Supabase.instance.client,
  );
});

final searchRepositoryProvider =
Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(
    remoteDataSource: ref.watch(
      searchRemoteDataSourceProvider,
    ),
  );
});

final searchUseCaseProvider =
Provider<SearchUseCase>((ref) {
  return SearchUseCase(
    ref.watch(searchRepositoryProvider),
  );
});

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(
      this._searchUseCase,
      ) : super(SearchState.initial());

  final SearchUseCase _searchUseCase;

  Timer? _debounce;

  Future<void> search(
      String query, {
        String? entityType,
      }) async {
    _debounce?.cancel();

    state = state.copyWith(
      query: query,
      entityType: entityType,
    );

    if (query.trim().length < 2) {
      state = SearchState.initial().copyWith(
        query: query,
        entityType: entityType,
      );
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () async {
        state = state.copyWith(
          isLoading: true,
          clearError: true,
        );

        try {
          final results = await _searchUseCase(
            query: query,
            entityType: entityType,
            limit: state.limit,
            offset: 0,
          );

          state = state.copyWith(
            results: results,
            isLoading: false,
            offset: results.length,
            hasMore: results.length == state.limit,
          );
        } catch (e) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: e.toString(),
          );
        }
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }

    state = state.copyWith(
      isLoadingMore: true,
    );

    try {
      final results = await _searchUseCase(
        query: state.query,
        entityType: state.entityType,
        limit: state.limit,
        offset: state.offset,
      );

      state = state.copyWith(
        results: [
          ...state.results,
          ...results,
        ],
        offset: state.offset + results.length,
        hasMore: results.length == state.limit,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clear() {
    _debounce?.cancel();
    state = SearchState.initial();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final searchProvider =
StateNotifierProvider<SearchNotifier, SearchState>(
      (ref) {
    return SearchNotifier(
      ref.watch(searchUseCaseProvider),
    );
  },
);