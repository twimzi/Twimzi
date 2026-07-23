import '../../domain/entities/post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_remote_datasource.dart';
import '../models/post_model.dart';

class PostsRepositoryImpl implements PostsRepository {
  const PostsRepositoryImpl({
    required this._remoteDataSource,
  });

  final PostsRemoteDataSource _remoteDataSource;

  @override
  Future<List<Post>> getPosts() {
    return _remoteDataSource.getPosts();
  }

  @override
  Future<Post> getPostById({
    required String postId,
  }) {
    return _remoteDataSource.getPostById(
      postId: postId,
    );
  }

  @override
  Future<List<Post>> getBusinessPosts({
    required String businessId,
  }) {
    return _remoteDataSource.getBusinessPosts(
      businessId: businessId,
    );
  }

  @override
  Future<List<Post>> getActivePosts() {
    return _remoteDataSource.getActivePosts();
  }

  @override
  Future<Post> createPost({
    required Post post,
  }) {
    return _remoteDataSource.createPost(
      post: PostModel.fromEntity(post),
    );
  }

  @override
  Future<Post> updatePost({
    required Post post,
  }) {
    return _remoteDataSource.updatePost(
      post: PostModel.fromEntity(post),
    );
  }

  @override
  Future<void> deletePost({
    required String postId,
  }) {
    return _remoteDataSource.deletePost(
      postId: postId,
    );
  }

  @override
  Future<bool> isPostActive({
    required String postId,
  }) {
    return _remoteDataSource.isPostActive(
      postId: postId,
    );
  }

  @override
  Future<void> togglePostStatus({
    required String postId,
    required bool isActive,
  }) {
    return _remoteDataSource.togglePostStatus(
      postId: postId,
      isActive: isActive,
    );
  }
}