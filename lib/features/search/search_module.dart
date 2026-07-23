import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/datasources/search_remote_datasource.dart';
import 'data/repositories/search_repository_impl.dart';
import 'domain/repositories/search_repository.dart';
import 'domain/usecases/search_usecase.dart';

/// ===============================================================
/// SEARCH MODULE DEPENDENCY INJECTION
/// ===============================================================

final searchSupabaseClientProvider = Provider<SupabaseClient>(
      (ref) => Supabase.instance.client,
);

final searchRemoteDataSourceProvider =
Provider<SearchRemoteDataSource>(
      (ref) => SearchRemoteDataSourceImpl(
    supabaseClient: ref.watch(searchSupabaseClientProvider),
  ),
);

final searchRepositoryProvider =
Provider<SearchRepository>(
      (ref) => SearchRepositoryImpl(
    remoteDataSource:
    ref.watch(searchRemoteDataSourceProvider),
  ),
);

final searchUseCaseProvider =
Provider<SearchUseCase>(
      (ref) => SearchUseCase(
    ref.watch(searchRepositoryProvider),
  ),
);