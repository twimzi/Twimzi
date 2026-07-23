import '../repositories/posts_repository.dart';

class DeletePostUseCase {
  const DeletePostUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<void> call({
    required String postId,
  }) {
    return _repository.deletePost(
      postId: postId,
    );
  }
}