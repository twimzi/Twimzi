import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class CreatePostUseCase {
  const CreatePostUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<Post> call({
    required Post post,
  }) {
    return _repository.createPost(
      post: post,
    );
  }
}