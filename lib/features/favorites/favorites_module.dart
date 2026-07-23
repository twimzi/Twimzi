import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/datasources/favorites_remote_datasource.dart';
import 'data/repositories/favorites_repository_impl.dart';
import 'domain/repositories/favorites_repository.dart';
import 'domain/usecases/add_favorite_usecase.dart';
import 'domain/usecases/get_favorites_by_type_usecase.dart';
import 'domain/usecases/get_favorites_usecase.dart';
import 'domain/usecases/is_favorite_usecase.dart';
import 'domain/usecases/remove_favorite_usecase.dart';
import 'domain/usecases/toggle_favorite_usecase.dart';

final favoritesSupabaseClientProvider = Provider<SupabaseClient>(
      (ref) => Supabase.instance.client,
);

final favoritesRemoteDataSourceProvider =
Provider<FavoritesRemoteDataSource>(
      (ref) => FavoritesRemoteDataSourceImpl(
    supabaseClient: ref.watch(
      favoritesSupabaseClientProvider,
    ),
  ),
);

final favoritesRepositoryProvider =
Provider<FavoritesRepository>(
      (ref) => FavoritesRepositoryImpl(
    remoteDataSource: ref.watch(
      favoritesRemoteDataSourceProvider,
    ),
  ),
);

final addFavoriteUseCaseProvider =
Provider<AddFavoriteUseCase>(
      (ref) => AddFavoriteUseCase(
    repository: ref.watch(
      favoritesRepositoryProvider,
    ),
  ),
);

final removeFavoriteUseCaseProvider =
Provider<RemoveFavoriteUseCase>(
      (ref) => RemoveFavoriteUseCase(
    repository: ref.watch(
      favoritesRepositoryProvider,
    ),
  ),
);

final toggleFavoriteUseCaseProvider =
Provider<ToggleFavoriteUseCase>(
      (ref) => ToggleFavoriteUseCase(
    repository: ref.watch(
      favoritesRepositoryProvider,
    ),
  ),
);

final isFavoriteUseCaseProvider =
Provider<IsFavoriteUseCase>(
      (ref) => IsFavoriteUseCase(
    repository: ref.watch(
      favoritesRepositoryProvider,
    ),
  ),
);

final getFavoritesUseCaseProvider =
Provider<GetFavoritesUseCase>(
      (ref) => GetFavoritesUseCase(
    repository: ref.watch(
      favoritesRepositoryProvider,
    ),
  ),
);

final getFavoritesByTypeUseCaseProvider =
Provider<GetFavoritesByTypeUseCase>(
      (ref) => GetFavoritesByTypeUseCase(
    repository: ref.watch(
      favoritesRepositoryProvider,
    ),
  ),
);