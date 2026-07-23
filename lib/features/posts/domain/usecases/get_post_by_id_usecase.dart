import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetPostByIdUseCase {
  const GetPostByIdUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<Post> call({
    required String postId,
  }) {
    return _repository.getPostById(
      postId: postId,
    );
  }
}