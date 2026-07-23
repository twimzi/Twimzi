import '../repositories/posts_repository.dart';

class IsPostActiveUseCase {
  const IsPostActiveUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<bool> call({
    required String postId,
  }) {
    return _repository.isPostActive(
      postId: postId,
    );
  }
}