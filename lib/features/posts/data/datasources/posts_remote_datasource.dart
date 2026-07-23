import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();

  Future<PostModel> getPostById({
    required String postId,
  });

  Future<List<PostModel>> getBusinessPosts({
    required String businessId,
  });

  Future<List<PostModel>> getActivePosts();

  Future<PostModel> createPost({
    required PostModel post,
  });

  Future<PostModel> updatePost({
    required PostModel post,
  });

  Future<void> deletePost({
    required String postId,
  });

  Future<bool> isPostActive({
    required String postId,
  });

  Future<void> togglePostStatus({
    required String postId,
    required bool isActive,
  });
}

class PostsRemoteDataSourceImpl
    implements PostsRemoteDataSource {
  PostsRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  static const _table = 'posts';

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await _supabase
        .from(_table)
        .select()
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PostModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<PostModel> getPostById({
    required String postId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('id', postId)
        .single();

    return PostModel.fromJson(response);
  }

  @override
  Future<List<PostModel>> getBusinessPosts({
    required String businessId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('business_id', businessId)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PostModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<List<PostModel>> getActivePosts() async {
    final response = await _supabase
        .from(_table)
        .select()
        .eq('is_active', true)
        .order(
      'created_at',
      ascending: false,
    );

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PostModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<PostModel> createPost({
    required PostModel post,
  }) async {
    final response = await _supabase
        .from(_table)
        .insert(post.toJson())
        .select()
        .single();

    return PostModel.fromJson(response);
  }

  @override
  Future<PostModel> updatePost({
    required PostModel post,
  }) async {
    final response = await _supabase
        .from(_table)
        .update(post.toJson())
        .eq('id', post.id)
        .select()
        .single();

    return PostModel.fromJson(response);
  }

  @override
  Future<void> deletePost({
    required String postId,
  }) async {
    await _supabase
        .from(_table)
        .delete()
        .eq('id', postId);
  }

  @override
  Future<bool> isPostActive({
    required String postId,
  }) async {
    final response = await _supabase
        .from(_table)
        .select('is_active')
        .eq('id', postId)
        .single();

    return response['is_active'] as bool? ?? false;
  }

  @override
  Future<void> togglePostStatus({
    required String postId,
    required bool isActive,
  }) async {
    await _supabase
        .from(_table)
        .update({
      'is_active': isActive,
    })
        .eq('id', postId);
  }
}