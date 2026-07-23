import '../entities/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();

  Future<Post> getPostById({
    required String postId,
  });

  Future<List<Post>> getBusinessPosts({
    required String businessId,
  });

  Future<List<Post>> getActivePosts();

  Future<Post> createPost({
    required Post post,
  });

  Future<Post> updatePost({
    required Post post,
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