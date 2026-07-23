import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class UpdatePostUseCase {
  const UpdatePostUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<Post> call({
    required Post post,
  }) {
    return _repository.updatePost(
      post: post,
    );
  }
}