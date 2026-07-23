import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/favorite.dart';
import '../models/favorite_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<FavoriteModel>> getFavorites();

  Future<List<FavoriteModel>> getFavoritesByType({
    required FavoriteType type,
  });

  Future<bool> isFavorite({
    required String entityId,
    required FavoriteType type,
  });

  Future<void> addFavorite({
    required String entityId,
    required FavoriteType type,
  });

  Future<void> removeFavorite({
    required String entityId,
    required FavoriteType type,
  });

  Future<void> toggleFavorite({
    required String entityId,
    required FavoriteType type,
  });

  Future<void> clearFavorites();
}

class FavoritesRemoteDataSourceImpl
    implements FavoritesRemoteDataSource {
  FavoritesRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  static const _table = 'favorites';

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return const [];
    }

    final response = await _supabase
        .from(_table)
        .select()
        .eq('user_id', userId)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(FavoriteModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<List<FavoriteModel>> getFavoritesByType({
    required FavoriteType type,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return const [];
    }

    final response = await _supabase
        .from(_table)
        .select()
        .eq('user_id', userId)
        .eq('entity_type', type.name)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(FavoriteModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> isFavorite({
    required String entityId,
    required FavoriteType type,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return false;
    }

    final response = await _supabase
        .from(_table)
        .select('id')
        .eq('user_id', userId)
        .eq('entity_id', entityId)
        .eq('entity_type', type.name)
        .maybeSingle();

    return response != null;
  }

  @override
  Future<void> addFavorite({
    required String entityId,
    required FavoriteType type,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw const AuthException(
        'User is not authenticated.',
      );
    }

    await _supabase.from(_table).insert({
      'user_id': userId,
      'entity_id': entityId,
      'entity_type': type.name,
    });
  }

  @override
  Future<void> removeFavorite({
    required String entityId,
    required FavoriteType type,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return;
    }

    await _supabase
        .from(_table)
        .delete()
        .eq('user_id', userId)
        .eq('entity_id', entityId)
        .eq('entity_type', type.name);
  }

  @override
  Future<void> toggleFavorite({
    required String entityId,
    required FavoriteType type,
  }) async {
    final exists = await isFavorite(
      entityId: entityId,
      type: type,
    );

    if (exists) {
      await removeFavorite(
        entityId: entityId,
        type: type,
      );
    } else {
      await addFavorite(
        entityId: entityId,
        type: type,
      );
    }
  }

  @override
  Future<void> clearFavorites() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      return;
    }

    await _supabase
        .from(_table)
        .delete()
        .eq('user_id', userId);
  }
}