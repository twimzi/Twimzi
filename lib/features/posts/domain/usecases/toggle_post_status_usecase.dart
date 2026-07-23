import '../repositories/posts_repository.dart';

class TogglePostStatusUseCase {
  const TogglePostStatusUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<void> call({
    required String postId,
    required bool isActive,
  }) {
    return _repository.togglePostStatus(
      postId: postId,
      isActive: isActive,
    );
  }
}